//
//  PaymentViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 12/15/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Stripe/Stripe.h"
#import "DetailViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PaymentViewController.h"

@interface PaymentViewController () <STPPaymentCardTextFieldDelegate>
{
    SystemSoundID applause;
    SystemSoundID groan;
}
@property (weak, nonatomic) STPPaymentCardTextField *paymentTextField;
@property (weak, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation PaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:21.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Billing Form", @"");
    [label sizeToFit];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    // Setup payment view
    STPPaymentCardTextField *paymentTextField = [[STPPaymentCardTextField alloc] init];
    paymentTextField.delegate = self;
    paymentTextField.cursorColor = [UIColor purpleColor];
    self.paymentTextField = paymentTextField;
    [_scroll addSubview:paymentTextField];
    
    // Setup Activity Indicator
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = YES;
    self.activityIndicator = activityIndicator;
    [_scroll addSubview:activityIndicator];
    
    NSURL *sound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"applause7" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)sound, & applause);
    NSURL *sound2 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"crowd-groan" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)sound2, & groan);
    
    _firstName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _lastName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _email.clearButtonMode = UITextFieldViewModeWhileEditing;
    _phone.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressOne.clearButtonMode = UITextFieldViewModeWhileEditing;
    _addressTwo.clearButtonMode = UITextFieldViewModeWhileEditing;
    _city.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGFloat padding = 10;
    CGFloat width = CGRectGetWidth(self.view.frame) - (padding * 2)+2;
    self.paymentTextField.frame = CGRectMake(padding, 300, width, 38);
    
    self.activityIndicator.center = self.view.center;
}

- (void)paymentCardTextFieldDidChange:(nonnull STPPaymentCardTextField *)textField {
    self.navigationItem.rightBarButtonItem.enabled = textField.isValid;
}

//- (void)paymentViewController:(PaymentViewController *)controller didFinish:(NSError *)error {
//    [self dismissViewControllerAnimated:YES completion:^{
//        if (error) {
//            [self presentError:error];
//        } else {
//            [self paymentSucceeded];
//        }
//    }];
//}
//
//- (void)presentError:(NSError *)error {
//    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [controller addAction:action];
//    [self presentViewController:controller animated:YES completion:nil];
//}
//
//- (void)paymentSucceeded {
//    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Success" message:@"Payment successfully created!" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
//    [controller addAction:action];
//    [self presentViewController:controller animated:YES completion:nil];
//}

- (void)save:(id)sender {
    if (![self.paymentTextField isValid]) {
        return;
    }
    if (![Stripe defaultPublishableKey]) {
        NSError *error = [NSError errorWithDomain:StripeDomain
                                             code:STPInvalidRequestError
                                         userInfo:@{
                                                    NSLocalizedDescriptionKey: @"Please specify a Stripe Publishable Key in Constants.m"
                                                    }];
        [self.delegate paymentViewController:self didFinish:error];
        return;
    }
    [self.activityIndicator startAnimating];
    [[STPAPIClient sharedClient] createTokenWithCard:self.paymentTextField.cardParams
                                          completion:^(STPToken *token, NSError *error) {
                                              [self.activityIndicator stopAnimating];
                                              if (error) {
                                                  [self.delegate paymentViewController:self didFinish:error];
                                              }
                                              [self.backendCharger createBackendChargeWithToken:token
                                                                                     completion:^(STPBackendChargeResult result, NSError *error) {
                                                                                         if (error) {
                                                                                             [self.delegate paymentViewController:self didFinish:error];
                                                                                             return;
                                                                                         }
                                                                                         [self.delegate paymentViewController:self didFinish:nil];
                                                                                     }];
                                          }];
}
- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)submitButton:(id)sender {
    _amountDonated = [[NSUserDefaults standardUserDefaults]integerForKey:@"amountDonated"];
    NSLog(@"amount %ld", (long)_amountDonated);
    _foodBankString = [[NSUserDefaults standardUserDefaults]objectForKey:@"foodBankString"];
    
    if([_phone.text length] != 10) {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Phone number is not 10 digits"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
    }    BOOL valid, valid2;
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:_phone.text];
    valid = [alphaNums isSupersetOfSet:inStringSet];
    if (!valid) {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Phone Number must only contain digits"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
    }
    NSCharacterSet *inStringSet2 = [NSCharacterSet characterSetWithCharactersInString:_zipcode.text];
    valid2 = [alphaNums isSupersetOfSet:inStringSet2];
    if (!valid2) {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Zip code must only contain digits"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
    }
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,10}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if ([emailTest evaluateWithObject:_email.text] == NO) {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Email address is invalid"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
        
        return;
    }
    
    if([_firstName.text isEqualToString:@""] || [_lastName.text isEqualToString:@""] || [_email.text isEqualToString:@""] || [_phone.text isEqualToString:@""] || [_addressOne.text isEqualToString:@""] || [_city.text isEqualToString:@""] || [_state.text isEqualToString:@""] || [_zipcode.text isEqualToString:@""])
    {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"All fields must be completed"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
        
    } else {
        NSString *amount = [NSString stringWithFormat:@"%ld", (long)_amountDonated];

        _amountString = [NSString stringWithFormat: @"Are you sure you want to donate $%@ to the %@", amount,_foodBankString];
        UIAlertController *success = [UIAlertController
                                      alertControllerWithTitle:@"Success"
                                      message:@"Thank your for your donation!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            _moneyRaisedString = [NSString stringWithFormat:@"%ld",(long)_finalAmount];
            [self viewDidLoad];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
        [success addAction:okAction];
        
        UIAlertController *confirm = [UIAlertController
                                      alertControllerWithTitle:@"Confirmation"
                                      message:_amountString
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            AudioServicesPlaySystemSound(groan);
        }];
        [confirm addAction:cancelAction];
        UIAlertAction *okAction2 = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            AudioServicesPlaySystemSound(applause);
            NSInteger getMoneyAmt = [_moneyRaisedString integerValue];
            _finalAmount = getMoneyAmt;
            _finalAmount = _finalAmount + _amountDonated;
            [self presentViewController: success animated: YES completion:nil];
            NSInteger check = 2;
            [[NSUserDefaults standardUserDefaults] setInteger:check forKey:@"checkAdd"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:_foodBankString forKey:@"getFoodBank"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:_foodBankString];
            NSInteger amount = _amountDonated;
            _amountDonated = _amountDonated + value;
            [[NSUserDefaults standardUserDefaults] setInteger:_amountDonated forKey:_foodBankString];
            [[NSUserDefaults standardUserDefaults] synchronize];
            NSInteger final = [[NSUserDefaults standardUserDefaults] integerForKey:@"final"];
            final = final + amount;
            [[NSUserDefaults standardUserDefaults] setInteger:final forKey:@"final"];
            [[NSUserDefaults standardUserDefaults] synchronize];

      
            
            
            
        }];
        [confirm addAction:okAction2];
        [self presentViewController: confirm animated: YES completion:nil];
        
    }
    
}

@end
