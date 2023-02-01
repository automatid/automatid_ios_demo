//
//  OTHFSettingsViewController.h
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 20/10/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@import Lottie;

NS_ASSUME_NONNULL_BEGIN

@interface OTHFSettingsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *obscurator;

@property (weak, nonatomic) IBOutlet UIView *documentsSettings;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) IBOutlet UILabel *extendedTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *useIdentityCardLabel;
@property (weak, nonatomic) IBOutlet UILabel *usePassoportLabel;
@property (weak, nonatomic) IBOutlet UISwitch *useIdentityCard;
@property (weak, nonatomic) IBOutlet UISwitch *usePassport;


@property (weak, nonatomic) IBOutlet UILabel *donePanelTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *donePanelExtendedLabel;

@property (weak, nonatomic) IBOutlet UIView *errorSettings;
@property (weak, nonatomic) IBOutlet UILabel *errorPanelTitleLabel;
@property (weak, nonatomic) IBOutlet UISwitch *shouldRetry;
@property (weak, nonatomic) IBOutlet UILabel *labelShouldRetry;
@property (weak, nonatomic) IBOutlet UILabel *extendedTextShouldRetry;
@property (weak, nonatomic) IBOutlet UILabel *extendedTextShouldRetry2;
@property (weak, nonatomic) IBOutlet UIButton *doneErrorsButton;



@property (weak, nonatomic) IBOutlet UILabel *titleIdMethodButton;
@property (weak, nonatomic) IBOutlet UILabel *subtitleIdMethodButton;
@property (weak, nonatomic) IBOutlet UILabel *titleErrorManagenentButton;
@property (weak, nonatomic) IBOutlet UILabel *subtitleErrorManagenentButton;
@property (weak, nonatomic) IBOutlet UIControl *errorManagenentButton;
@property (weak, nonatomic) IBOutlet UIControl *idMethodButton;


@property (weak, nonatomic) IBOutlet UIButton *closeDocumentsPanelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneDocumentsButton;


@property (weak, nonatomic) IBOutlet UIImageView *backgroundPanel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundErrorPanel;
@property (weak, nonatomic) IBOutlet LOTAnimationView *animationView;

@end

NS_ASSUME_NONNULL_END
