//
//  OTHFResultViewController.h
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 20/10/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AutomatID;
@import Lottie;

NS_ASSUME_NONNULL_BEGIN

@interface OTHFResultViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *feedbackImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *shareJWTButton;
@property (weak, nonatomic) IBOutlet LOTAnimationView *animationView;

-(void) showResult:(AutomatIDResultSuccess*) result;
-(void) showError:(AutomatIDResultError*) result;

-(IBAction) shareJWT;
-(IBAction) dismissResultViewController;

@end

NS_ASSUME_NONNULL_END
