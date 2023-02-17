//
//  OTHFTermsAndConditionsViewController.m
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 21/10/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import "OTHFTermsAndConditionsViewController.h"

@interface OTHFTermsAndConditionsViewController ()<WKNavigationDelegate>

@end

@implementation OTHFTermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL* url = [NSURL URLWithString:@"https://docs.automat-id.com/privacy.html"];
    NSURLRequest* request = [[NSURLRequest alloc] initWithURL:url];
    self.extendedTextLbel.navigationDelegate = self;
    self.extendedTextLbel.backgroundColor = self.view.backgroundColor;
    [self.extendedTextLbel loadRequest:request];
    self.extendedTextLbel.hidden = YES;

    self.doneButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:17];
    self.doneButton.titleLabel.text = NSLocalizedString(@"tc_btn_accept", @"");

    BOOL termsAndConditionsNotAccepted = (self.onTermsAndConditionAccepted == NULL);
    self.doneButton.hidden = termsAndConditionsNotAccepted;
    self.buttonHeightConstraint.constant = termsAndConditionsNotAccepted ? 0 : 60;
}

-(IBAction) closeTermsAndConditions
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(IBAction) acceptTermsAndConditions
{
    self.onTermsAndConditionAccepted(); // self.onTermsAndConditionAccepted != NULL when the button is enabled
    [self closeTermsAndConditions];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
    self.extendedTextLbel.hidden = NO;
}

@end
