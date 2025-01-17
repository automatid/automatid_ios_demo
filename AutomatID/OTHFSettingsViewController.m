//
//  OTHFSettingsViewController.m
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 20/10/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

#import "OTHFSettingsViewController.h"

@interface OTHFSettingsViewController ()

@end

@implementation OTHFSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    self.usePassport.on = ![defaults boolForKey:@"doNotAcceptPassport"];
    self.useIdentityCard.on = ![defaults boolForKey:@"doNotAcceptIdentityCard"];
    self.shouldRetry.on = ![defaults boolForKey:@"doNotRetryOnError"];

    [self updateDocumentsButtonSubtitle];
    [self updateErrorButtonSubtitle];

    self.errorLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:12];

    self.extendedTextLabel.font = [UIFont fontWithName:@"Montserrat-Regular" size:15];

    UIFont * _Nullable panelTitleFont = [UIFont fontWithName:@"Montserrat-Bold" size:20];
    UIFont * _Nullable panelExtendedLabelFont = [UIFont fontWithName:@"Montserrat-Regular" size:15];

    self.titleTextLabel.font = panelTitleFont;

    self.donePanelTitleLabel.font = panelTitleFont;
    self.donePanelExtendedLabel.font = panelExtendedLabelFont;

    UIFont * _Nullable switchLabelFont = [UIFont fontWithName:@"Montserrat-Regular" size:14];
    self.useIdentityCardLabel.font = switchLabelFont;
    self.usePassoportLabel.font = switchLabelFont;


    self.titleIdMethodButton.font = [UIFont fontWithName:@"Montserrat-Medium" size:16];
    self.subtitleIdMethodButton.font = [UIFont fontWithName:@"Montserrat-Regular" size:12];
    self.titleErrorManagenentButton.font = [UIFont fontWithName:@"Montserrat-Medium" size:16];
    self.subtitleErrorManagenentButton.font = [UIFont fontWithName:@"Montserrat-Regular" size:12];


    self.doneDocumentsButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:17];
    UIImage* image = [self.backgroundPanel.image stretchableImageWithLeftCapWidth:20 topCapHeight:20];
    self.backgroundPanel.image = image;
    self.backgroundErrorPanel.image = image;

    self.errorPanelTitleLabel.font = panelTitleFont;

    self.labelShouldRetry.font = switchLabelFont;

    self.extendedTextShouldRetry.font = panelExtendedLabelFont;
    self.extendedTextShouldRetry2.font = [UIFont fontWithName:@"Montserrat-Regular" size:14];

    self.doneErrorsButton.titleLabel.font = [UIFont fontWithName:@"Montserrat-Bold" size:17];

    NSString* placeholer = self.shouldRetry.isOn?@"error_management_body2_retry":@"error_management_body2_abort";
    self.extendedTextShouldRetry2.text = NSLocalizedString(placeholer, @"");
    
    NSString* lottieFileName = @"sci_demo_app_feedback_settings";
    [self.animationView setAnimation:lottieFileName];

    self.view.layer.borderWidth = 2;
    [self.animationView play];

    UIColor* _Nonnull borderColor = [UIColor colorWithRed:46.0/255.0 green:58.0/255.0 blue:73.0/255.0 alpha:1.0];
    self.titleIdMethodButton.textColor = borderColor;
    self.subtitleIdMethodButton.textColor = borderColor;
    self.errorManagenentButton.layer.cornerRadius = 8.0;
    self.errorManagenentButton.layer.borderWidth = 2;
    self.errorManagenentButton.layer.borderColor = borderColor.CGColor;

    self.titleErrorManagenentButton.textColor = borderColor;
    self.subtitleErrorManagenentButton.textColor = borderColor;
    self.idMethodButton.layer.cornerRadius = 8.0;
    self.idMethodButton.layer.borderWidth = 2;
    self.idMethodButton.layer.borderColor = borderColor.CGColor;
}


-(IBAction) closeDocumentsSettings
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.usePassport.on = ![defaults boolForKey:@"doNotAcceptPassport"];
    self.useIdentityCard.on = ![defaults boolForKey:@"doNotAcceptIdentityCard"];
    if (!self.useIdentityCard.isOn && !self.usePassport.isOn) {
        self.doneDocumentsButton.enabled = NO;
        self.doneDocumentsButton.alpha = 0.5;

        self.errorLabel.hidden = NO;
    } else {
        self.doneDocumentsButton.enabled = YES;
        self.doneDocumentsButton.alpha = 1.0;
        self.errorLabel.hidden = YES;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.errorSettings.alpha = 0.0;
        self.documentsSettings.alpha = 0.0;
        self.obscurator.alpha =  0.0;
    }completion:^(BOOL finished) {
        self.errorSettings.hidden = YES;
        self.documentsSettings.hidden = YES;
    }];
}

-(IBAction) showDocumentsSettings
{
    self.documentsSettings.hidden = NO;
    self.documentsSettings.alpha =  0.0;
    self.obscurator.hidden = NO;
    self.obscurator.alpha =  0.0;

    [UIView animateWithDuration:0.3 animations:^{
        self.documentsSettings.alpha = 1.0;
        self.obscurator.alpha =  1.0;
    }];
}

-(IBAction)onSwitchSelected:(id)sender
{
    if (sender == self.shouldRetry) {
        NSString* placeholer = self.shouldRetry.isOn?@"error_management_body2_retry":@"error_management_body2_abort";
        self.extendedTextShouldRetry2.text = NSLocalizedString(placeholer, @"");
        return;
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (!self.useIdentityCard.isOn && !self.usePassport.isOn) {
            self.doneDocumentsButton.enabled = NO;
            self.doneDocumentsButton.alpha = 0.5;

            self.errorLabel.hidden = NO;
        } else {
            self.doneDocumentsButton.enabled = YES;
            self.doneDocumentsButton.alpha = 1.0;
            self.errorLabel.hidden = YES;
        }
    }];
}

- (void)updateDocumentsButtonSubtitle {

    NSMutableString* localyzedSubtitle = @"".mutableCopy;
    if (self.usePassport.isOn) {
        [localyzedSubtitle appendString:NSLocalizedString(@"id_methods_passport_short", @"Passports")];
    }
    if (self.useIdentityCard.isOn) {
        if (localyzedSubtitle.length > 0) {
            [localyzedSubtitle appendString:@", "];
        }
        NSString * _Nonnull idCard = NSLocalizedString(@"id_methods_identity_card_short", @"Identity cards");
        [localyzedSubtitle appendString:idCard];
    }
    // "DOCUMENT_TYPE_IDCARD" = "Identity cards";
    if (@available(iOS 15.0, *)) {
        UILabel * _Nullable subtitleLabel = self.subtitleIdMethodButton;
        subtitleLabel.text = localyzedSubtitle;
        [subtitleLabel sizeToFit];
        [subtitleLabel setNeedsDisplay];
        [subtitleLabel setNeedsLayout];
    } else {
        NSLog(@"subtitle is visible only for iOS > 15.0");
    }
}

- (void)updateErrorButtonSubtitle {
    NSMutableString* localyzedSubtitle = @"".mutableCopy;
    if (self.shouldRetry.isOn) {
        NSString * _Nonnull retryText = NSLocalizedString(@"error_management_retry_short", @"Retry on errors");
        [localyzedSubtitle appendString:retryText];
    } else {
        NSString * _Nonnull doNotRetryText = NSLocalizedString(@"error_management_abort_short", @"Retry on errors");
        [localyzedSubtitle appendString:doNotRetryText];
    }

    if (@available(iOS 15.0, *)) {
        UILabel * _Nullable subtitleLabel = self.subtitleErrorManagenentButton;
        subtitleLabel.text = localyzedSubtitle;
        [subtitleLabel sizeToFit];
        [subtitleLabel setNeedsDisplay];
        [subtitleLabel setNeedsLayout];
    } else {
        NSLog(@"subtitle is visible only for iOS > 15.0");
    }
}

-(IBAction) documentSettingsDonePressed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:!self.usePassport.isOn forKey:@"doNotAcceptPassport"];
    [defaults setBool:!self.useIdentityCard.isOn forKey:@"doNotAcceptIdentityCard"];
    [self closeDocumentsSettings];
    [self updateDocumentsButtonSubtitle];
}

-(IBAction) errorSettingsDonePressed
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:!self.shouldRetry.isOn forKey:@"doNotRetryOnError"];

    [self closeErrorSettings];
    [self updateErrorButtonSubtitle];

}

-(IBAction) closeSettings
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction) showErrorSettings
{
    self.documentsSettings.hidden = YES;
    self.documentsSettings.alpha = 0.0;
    self.errorSettings.hidden = NO;
    self.errorSettings.alpha =  0.0;
    self.obscurator.hidden = NO;
    self.obscurator.alpha =  0.0;

    [UIView animateWithDuration:0.3 animations:^{
        self.errorSettings.alpha = 1.0;
        self.obscurator.alpha =  1.0;
    }];
}

-(IBAction) closeErrorSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.shouldRetry.on = ![defaults boolForKey:@"doNotRetryOnError"];

    [UIView animateWithDuration:0.3 animations:^{
        self.errorSettings.alpha = 0.0;
        self.obscurator.alpha =  0.0;
    }completion:^(BOOL finished) {
        self.errorSettings.hidden = YES;
        self.obscurator.hidden = YES;
    }];
}


@end
