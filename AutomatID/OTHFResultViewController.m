//
//  OTHFResultViewController.m
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 20/10/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import "OTHFResultViewController.h"


@interface OTFHResultSyccessView : UIView



@end

@implementation OTFHResultSyccessView

+ (BOOL)requiresConstraintBasedLayout 
{
    return YES;
}

@end

@interface OTHFResultViewController ()
@property NSString* lastReceivedJWT;
@property NSString* animationToPlay;
@property NSString* titleText;
@property NSString* feedbackBody;

@end

@implementation OTHFResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self.animationView setAnimation:self.animationToPlay];


    self.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:22];
    self.feedbackLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:17];
    self.doneButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:17];
    self.shareJWTButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:17];

    self.titleLabel.text = self.titleText;
    self.feedbackLabel.text = self.feedbackBody;

    [self.animationView play];
    self.doneButton.titleLabel.text = NSLocalizedString(@"feedback_btn_close", @"");

    self.shareJWTButton.titleLabel.text = NSLocalizedString(@"feedback_share_jwt", @"");

    self.shareJWTButton.hidden = self.lastReceivedJWT == nil;
}


-(void) showError:(AutomatIDResultError*) result
{
    self.shareJWTButton.hidden = YES;

    NSString* feedbackTitleText = nil;
    if (result.technicalDescription.length > 0) {
        feedbackTitleText = [NSString stringWithFormat:@"Error code: %@\nError domain: %@\nTechincalDescription: %@", @(result.code) , result.domain, result.technicalDescription];
    } else {
        feedbackTitleText = [NSString stringWithFormat:@"Error code: %@\nError domain: %@", @(result.code) , result.domain];
    }
    self.titleText = NSLocalizedString(@"feedback_title_error", @"");
    self.feedbackBody = feedbackTitleText;
    self.animationToPlay =  @"sci_demo_app_feedback_error";
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
