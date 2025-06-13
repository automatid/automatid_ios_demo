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
#import "OTHFSuccessViewController.h"

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

//    [self mockResultScreen];
//    [self mockErrorScreen];
}

- (void) mockResultScreen
{
    AutomatIDResultSuccess* success = [[AutomatIDResultSuccess alloc] init];

    success.usedDocument = AutomatIDDocumentTypes_PASSPORT;
    success.jwt = @"eyJraWQiOiJrZXlJZEF1dG9tYXRJRFByZSIsImFsZyI6IlJTMjU2In0.ewogICJuYmYiOiAxNjk0MDgzOTYyLAogICJwaG90b01hdGNoaW5nUmVzdWx0IjogOTkuOTU4NywKICAic3VybmFtZSI6ICJCSUFOQ0hJIiwKICAiZG9jdW1lbnROdW1iZXIiOiAiQ0EyNDg0OUlVIiwKICAibmFtZSI6ICJBTEVTU0lPIiwKICAiaXNzIjogIk9wZW50ZWNoIiwKICAiZGF0ZU9mQmlydGgiOiAiODUwMzA3IiwKICAiZXhwIjogMTY5NDA4NDg2MiwKICAiaWF0IjogMTY5NDA4Mzk2MiwKICAiZG9jdW1lbnRQaG90byI6ICJcLzlqXC80QUFRU2taOVVBdUIyb0ZGQVwvblFJV2lseFJUQVwvXC85az0iCn0=.RcXIA2YqrkJ2qlz30a5uAhdKm7NITyzMC71zES7XsW8xXTMJ0i4xW2wE72LVG9lik7KwKBmOSrXwuR7-xLiimhk6tV_iO4E_Wtbrx0jMTcGU3fWrBNiHb8u5l3p4nbaHxKBS1SsSVYxpFy3VNwGsd6v78tSOowQQOYHBODxz3iR8Am8HHgXj9A66bDpMogAdwQZLYBmoNmZ6VBWGFfiUqsIZ0meSlAWGvWTbs_Yc_pFkYanLf-pzEaZbyEtMLZMsEZNjrRSJNdcEtheu8zC7UYhP66M877PPAFE9fglz9mJqZwKDuKlrjgXV5WFUnEkG0L6EQOLD1vDQ6EmlMqPXRg";

    [self handleSuccess:success];
}

- (void) mockErrorScreen
{
    AutomatIDResultError* error = [[AutomatIDResultError alloc] init];
    error.domain = @"domain error";
    error.code = AutomatIDErrorCode_CONFIG_FILE_DECRYPTION_FAILED;
    [self handleError:error];
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
    BOOL shouldRetryOnError = ![defaults boolForKey:@"doNotRetryOnError"];

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
    UIViewController* theVC = [sboard instantiateViewControllerWithIdentifier:@"successresultviewcontroller"];
    theVC.modalPresentationStyle = UIModalPresentationFullScreen;
    OTHFSuccessViewController* vc = (OTHFSuccessViewController*)theVC;
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
        NSLog(@"OTHFSuccessViewController on screen");
    }];
}



@end


