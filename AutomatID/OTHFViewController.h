//
//  OTHFViewController.h
//  AutomatID
//
//  Created by ios@opentech.com on 07/10/2022.
//  Copyright (c) 2022 opentech.com All rights reserved.
//

@import UIKit;
@import Lottie;

@interface OTHFViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *extendedTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *startPluginButton;
@property (weak, nonatomic) IBOutlet LOTAnimationView *animationView;

@property (weak, nonatomic) IBOutlet UILabel *dataSecurityLabel;

//@property (weak, nonatomic) IBOutlet LOTAnimationView *animationView;

-(IBAction)launchPressed:(id)sender;

@end
