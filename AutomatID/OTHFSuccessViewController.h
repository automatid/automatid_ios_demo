//
//  OTHFSuccessViewController.h
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 15/03/24.
//  Copyright © 2024 opentech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AutomatID;
@import Lottie;

NS_ASSUME_NONNULL_BEGIN

@interface OTHFSuccessViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *feedbackImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *shareJWTButton;
@property (weak, nonatomic) IBOutlet LOTAnimationView *animationView;

@property (weak, nonatomic) IBOutlet UIView *authenticationResultDisplay;
@property (weak, nonatomic) IBOutlet UILabel *issuingAuthorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *documentDataIntegrityLabel;
@property (weak, nonatomic) IBOutlet UILabel *livenessCheckLabel;
@property (weak, nonatomic) IBOutlet UILabel *faceCOmparisonMatchingLabel;

@property (weak, nonatomic) IBOutlet UIImageView *issuingAuthorityCheck;
@property (weak, nonatomic) IBOutlet UIImageView *documentDataIntegrityCheck;
@property (weak, nonatomic) IBOutlet UIImageView *livenessCheckLabelCheck;
@property (weak, nonatomic) IBOutlet UILabel *faceCOmparisonMatchingCheck;

-(void) showResult:(AutomatIDResultSuccess*) result;

-(IBAction) shareJWT;
-(IBAction) dismissResultViewController;
@end

NS_ASSUME_NONNULL_END
