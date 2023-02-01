//
//  OTHFTermsAndConditionsViewController.h
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 21/10/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@interface OTHFTermsAndConditionsViewController : UIViewController

@property BOOL shouldBeAccepted;

@property (nonatomic, copy, nullable) void (^onTermsAndConditionAccepted)(void);

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet WKWebView *extendedTextLbel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

-(IBAction) closeTermsAndConditions;

-(IBAction) acceptTermsAndConditions;

@end

NS_ASSUME_NONNULL_END
