//
//  OTHFSuccessViewController.m
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 15/03/24.
//  Copyright © 2024 opentech.com. All rights reserved.
//

#import "OTHFSuccessViewController.h"
#import <AutomatID_OTMLCore/OTMPBase64.h>


@interface OTHFSuccessViewController ()

@property NSString* lastReceivedJWT;
@property NSString* animationToPlay;
@property NSString* titleText;
@property NSString* feedbackBody;

@end

@implementation OTHFSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.animationView setAnimation:self.animationToPlay];


    UIFont * _Nullable bigFont = [UIFont fontWithName:@"Montserrat-Bold" size:18];
    UIFont * _Nullable littleFont = [UIFont fontWithName:@"Montserrat-Regular" size:14];
    UIFont * _Nullable mediumFont = [UIFont fontWithName:@"Montserrat-Regular" size:15];

    UIFont * _Nullable buttonFont = [UIFont fontWithName:@"Montserrat-Bold" size:17];

    self.titleLabel.font = bigFont;
    self.feedbackLabel.font = littleFont;

    self.doneButton.titleLabel.font = buttonFont;
    self.shareJWTButton.titleLabel.font = buttonFont;

    self.issuingAuthorityLabel.font = mediumFont;
    self.issuingAuthorityLabel.text = NSLocalizedString(@"issuing_authority_authenticity", @"");

    self.documentDataIntegrityLabel.font = mediumFont;
    self.documentDataIntegrityLabel.text = NSLocalizedString(@"document_data_integrity", @"");

    self.livenessCheckLabel.font = mediumFont;
    self.livenessCheckLabel.text = NSLocalizedString(@"liveness_check", @"");

    self.faceCOmparisonMatchingLabel.font = mediumFont;
    self.faceCOmparisonMatchingLabel.text = NSLocalizedString(@"face_comparison_matching", @"");

    self.titleLabel.text = self.titleText;
    self.feedbackLabel.text = self.feedbackBody;

    [self.animationView play];
    self.doneButton.titleLabel.text = NSLocalizedString(@"feedback_btn_close", @"");

    self.shareJWTButton.titleLabel.text = NSLocalizedString(@"feedback_share_jwt", @"");

    self.shareJWTButton.hidden = self.lastReceivedJWT == nil;

    NSInteger comparisonMatchingRate = [self comparisonMatchingRateFromJWT:self.lastReceivedJWT];

    self.faceCOmparisonMatchingCheck.text = [NSString stringWithFormat:@"%@%@", @(comparisonMatchingRate), @"%"];
}

-(NSInteger) comparisonMatchingRateFromJWT:(NSString*)aJWT
{
    NSArray* splitted = [aJWT componentsSeparatedByString:@"."];
    NSString* middleElement = splitted[1];
    middleElement = [self base64urlToBase64:middleElement];
    NSData* clearELement = [OTMPBase64 dataOfBase64String:middleElement];
    NSError* err = nil;
    NSDictionary* jsonELement = [NSJSONSerialization JSONObjectWithData:clearELement options:NSJSONReadingMutableLeaves error:&err];
    NSInteger toReturn = -1;
    if (err == nil) {
        NSNumber* something = jsonELement[@"photoMatchingResult"];
        NSInteger castedToInnt = [something integerValue];
        toReturn = castedToInnt;
    }
    return toReturn;
}

- (NSString *)base64urlToBase64:(NSString *)base64url {
    NSString *base64 = [base64url stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64 = [base64 stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSInteger padding = 4 - (base64.length % 4);
    if (padding != 4) {
        base64 = [base64 stringByPaddingToLength:base64.length + padding withString:@"=" startingAtIndex:0];
    }
    return base64;
}

-(void) showResult:(AutomatIDResultSuccess*) result
{
    self.shareJWTButton.hidden = NO;
    self.lastReceivedJWT = result.jwt;
    self.animationToPlay = @"sci_demo_app_feedback_success";

    NSString * _Nonnull titleText = NSLocalizedString(@"feedback_title_success", @"");
    self.titleText = titleText;
    NSString * _Nonnull feedbackText = NSLocalizedString(@"feedback_body_success", @"");
    self.feedbackBody = feedbackText;

}

-(IBAction) shareJWT
{
    if (self.lastReceivedJWT) {
        UIActivityViewController * activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[self.lastReceivedJWT] applicationActivities:nil];
        activityViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:activityViewController animated:YES completion:nil];
    }
}

-(IBAction) dismissResultViewController
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
