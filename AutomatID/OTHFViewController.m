//
//  OTHFViewController.m
//  AutomatID
//
//  Created by ios@opentech.com on 07/10/2022.
//  Copyright (c) 2022 opentech.com All rights reserved.
//

#import "OTHFViewController.h"
#import "OTHFResultViewController.h"
#import "OTHFTermsAndConditionsViewController.h"

@import AutomatID;

@interface OTHFViewController ()<UITextFieldDelegate>

@end

@implementation OTHFViewController

-(void)viewDidLoad
{
    [super viewDidLoad];

    self.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:20];
    self.subTitleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:20];
    self.extendedTextLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:15];

    self.dataSecurityLabel.attributedText = [self.class attributedStringFromText:self.dataSecurityLabel.attributedText
                                                                    andAlignment:NSTextAlignmentJustified];

    self.startPluginButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:17];

    NSString * _Nonnull startPluginButton = NSLocalizedString(@"welcome_btn_start", @"");
    self.startPluginButton.titleLabel.text = startPluginButton;

    self.animationView.animation = @"sci_demo_app_landing_animation";
    [self.animationView play];
}


+ (NSMutableAttributedString*) attributedStringFromText:(NSAttributedString*) attribitedString
                                           andAlignment:(NSTextAlignment) textAlignment
{
    UIFont* regular = [UIFont fontWithName:@"Montserrat-Regular" size:12];
    UIFont* bold = [UIFont fontWithName:@"Montserrat-Bold" size:12];

    NSMutableAttributedString *attrString = attribitedString.mutableCopy;

    NSMutableDictionary<NSString*,UIFont*>* changes = [NSMutableDictionary dictionaryWithCapacity:3];


    [attrString enumerateAttribute:NSFontAttributeName
                           inRange:NSMakeRange(0, attrString.length)
                           options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                        usingBlock:^(UIFont*  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        UIFontDescriptorSymbolicTraits traitsFRomOtherFont = value.fontDescriptor.symbolicTraits;
        UIFontDescriptor* baseFontDescriptor = nil;
        if (traitsFRomOtherFont&UIFontDescriptorTraitBold) {
            baseFontDescriptor = bold.fontDescriptor;
        } else {
            baseFontDescriptor = regular.fontDescriptor;
        }
        UIFontDescriptor* adjustedFontDescriptor = [baseFontDescriptor fontDescriptorWithSymbolicTraits:traitsFRomOtherFont];
        UIFont* theRenewFont = [UIFont fontWithDescriptor:adjustedFontDescriptor size:baseFontDescriptor.pointSize];
        changes[NSStringFromRange(range)] = theRenewFont;
    }];

    for (NSString* wasARange in changes.allKeys) {
        NSRange rangeStoredInDictionary = NSRangeFromString(wasARange);
        [attrString removeAttribute:NSFontAttributeName range:rangeStoredInDictionary];
        [attrString addAttribute:NSFontAttributeName value:changes[wasARange] range:rangeStoredInDictionary];
    }

    NSMutableParagraphStyle* thePStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    thePStyle.alignment = textAlignment;
    thePStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:thePStyle
                       range:NSMakeRange(0, attrString.length)];

    return attrString;
}



-(IBAction)launchPressed:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL termsAndConditionShown = [defaults boolForKey:@"termsAndConditionAccepted"];
    if (!termsAndConditionShown) {
        [self forcedOpenTermsAndConditions];
        return;
    }

    BOOL useIdentityCard = ![defaults boolForKey:@"doNotAcceptIdentityCard"];
    BOOL usePassport = ![defaults boolForKey:@"doNotAcceptPassport"];
    BOOL shouldRetryOnError = [defaults boolForKey:@"retryOnError"];

    NSMutableArray<AutomatIDDocumentType*>* docTypes = @[].mutableCopy;

    if (useIdentityCard) {
        [docTypes addObject:AutomatIDDocumentType.identityCard];
    }
    if (usePassport) {
        [docTypes addObject:AutomatIDDocumentType.passport];
    }


    AutomatIDCallback* callback = [[AutomatIDCallback alloc] init];
    // optional, defaults to RETRY
    callback.decideRecoverableErrorHandling = ^RecoverableErrorHandlingDecision(AutomatIDResultError * _Nonnull error) {
        if (shouldRetryOnError) {
            return ErrorHandlingDecision_RETRY_SCI;
        } else {
            [self handleError:error];
            return ErrorHandlingDecision_ABORT_SCI;
        }
    };
    callback.onError = ^void(AutomatIDResultError * _Nonnull error) {
        [self handleError:error];
    };

    callback.onCancel = ^{
        NSLog(@"user cancelled automatID");
    };
    callback.onSuccess = ^(AutomatIDResultSuccess * _Nonnull success) {
        [self handleSuccess:success];
    };
    
    AutomatIDRequest* request = [AutomatIDRequest requestWithDocumentTypes:docTypes];
    [AutomatIDManager startIdentificationWithRequest:request andCompletion:callback];
}

-(IBAction) openSettingsView
{
    UIStoryboard * sboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    UIViewController* theVC = [sboard instantiateViewControllerWithIdentifier:@"settingsviewcontroller"];

    [self.navigationController pushViewController:theVC animated:YES];
}

-(void) forcedOpenTermsAndConditions
{
    UIStoryboard * sboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    OTHFTermsAndConditionsViewController* theVC = (OTHFTermsAndConditionsViewController*)[sboard instantiateViewControllerWithIdentifier:@"termsandconditionsviewcontroller"];
    theVC.onTermsAndConditionAccepted = ^{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"termsAndConditionAccepted"];
        [self launchPressed:nil];
    };

    theVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:theVC animated:YES completion:NULL];
}

-(IBAction) openTermsAndConditions
{
    UIStoryboard * sboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    OTHFTermsAndConditionsViewController* theVC = (OTHFTermsAndConditionsViewController*)[sboard instantiateViewControllerWithIdentifier:@"termsandconditionsviewcontroller"];
    theVC.onTermsAndConditionAccepted = NULL;
    theVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:theVC animated:YES completion:NULL];
}

-(void) handleSuccess:(AutomatIDResultSuccess*) success
{
    UIStoryboard * sboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    UIViewController* theVC = [sboard instantiateViewControllerWithIdentifier:@"resultviewcontroller"];
    theVC.modalPresentationStyle = UIModalPresentationFullScreen;
    OTHFResultViewController* vc = (OTHFResultViewController*)theVC;
    [vc showResult:success];
    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"OTHFResultViewController on screen");
    }];
}

-(void) handleError:(AutomatIDResultError*) error
{
    UIStoryboard * sboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    UIViewController* theVC = [sboard instantiateViewControllerWithIdentifier:@"resultviewcontroller"];
    theVC.modalPresentationStyle = UIModalPresentationFullScreen;
    OTHFResultViewController* vc = (OTHFResultViewController*)theVC;
    [vc showError:error];

    [self presentViewController:vc animated:YES completion:^{
        NSLog(@"OTHFResultViewController on screen");
    }];
}

@end


