//
//  OTHFAppDelegate.m
//  AutomatID
//
//  Created by ios@opentech.com on 07/10/2022.
//  Copyright (c) 2022 opentech.com All rights reserved.
//

#import "OTHFAppDelegate.h"
#import "ProjectConfigurationAutomatID_DEMO_IOS.h"

@import AutomatID;

@implementation OTHFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSError * error = nil;
    
    NSBundle *amazingBundle = [NSBundle bundleForClass:[self class]];
    NSString * path = [amazingBundle.bundlePath stringByAppendingPathComponent:@"Licenses"];
    path = [path stringByAppendingPathComponent:OMVLICENSE];
    path = [path stringByAppendingString:@".sci"];
    
    NSLog(@"Loading config file: %@", path);

    AutomatIDConfiguration* configuration = [[AutomatIDConfiguration alloc] init];

    [configuration addStringsForLocale:@"en_us" withPlaceholders:@{
        @"popup_popup_generic_ok" : @"$OYEAH!"
    }];

    [configuration addStringsForLocale:@"en_en" withPlaceholders:@{
        @"popup_popup_generic_ok" : @"YEAH!"
    }];

    for (NSString* familyStr in [UIFont familyNames]) {
        NSLog(@"%@ font names are: %@",familyStr, [UIFont fontNamesForFamilyName:familyStr]);
    }
    UIFont* regularFont = [UIFont fontWithName:@"Montserrat-Regular" size:12]; // size is overridden, same Font is shown at different sizes
    UIFont* mediumFont = [UIFont fontWithName:@"Montserrat-Medium" size:12]; // size is overridden, same Font is shown at different sizes
    UIFont* boldFont = [UIFont fontWithName:@"Montserrat-Bold" size:12]; // size is overridden, same Font is shown at different sizes
    configuration.defaultFontRegular = regularFont;
    configuration.defaultFontMedium = mediumFont;
    configuration.defaultFontBold = boldFont;

    configuration.titleFontBold = boldFont;
    configuration.titleFontRegular = regularFont;
    configuration.titleFontMedium = mediumFont;

    configuration.buttonFontBold = boldFont;
    configuration.buttonFontRegular = regularFont;
    configuration.buttonFontMedium = mediumFont;


    BOOL done = [AutomatIDManager configureWithFile:path
                                  withConfiguration:configuration
                                          withError:&error];
    if(!done || error){
        NSLog(@"Error on AutomatID configuration %@", error);
    }    
    
    return YES;
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    // NOTE: it is required to implement this method in order to rotate to landscape orientation the scanner view controller.
    if (AutomatIDManager.isOnScreen) {
        return [AutomatIDManager evaluateCurrentOrientation];
    } else {
        return UIInterfaceOrientationMaskPortrait; // whatever is your app proper orientation
    }
}

@end
