//
//  SignUpViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/10/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "SignUpViewController.h"
#import "DonateFoodViewController.h"
#import "KeychainItemWrapper.h"




@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _companyBtn.layer.cornerRadius = 8;
    _companyBtn.layer.borderWidth = 1;
    _companyBtn.layer.borderColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0].CGColor;
    _directorBtn.layer.cornerRadius = 8;
    _directorBtn.layer.borderWidth = 1;
    _directorBtn.layer.borderColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0].CGColor;
    
    _profileTag = 0;
    
    _usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _reenterPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    _companyName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _companyEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
    _companyPhone.clearButtonMode = UITextFieldViewModeWhileEditing;
    _companyType.clearButtonMode = UITextFieldViewModeWhileEditing;

   
}



- (void)loadView
{
    [super loadView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:19.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Create a new account", @"");
    [label sizeToFit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)roleChosen:(UIButton *)button {

    if(button.tag == 1) {
        [_directorBtn setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1] forState:UIControlStateNormal];
        _directorBtn.backgroundColor = [UIColor clearColor];
        [_companyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _companyBtn.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
        _companyName.placeholder = @"company name";
        _companyEmail.placeholder = @"company email";
        _companyPhone.placeholder = @"company phone";
        _companyType.placeholder = @"company type i.e. restaurant, manufacturer, retailer,...";
        _profileTag = 1;
    } else if(button.tag == 2) {
        _companyBtn.backgroundColor = [UIColor clearColor];
        [_companyBtn setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_directorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _directorBtn.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
        _companyName.placeholder = @"food bank employer";
        _companyEmail.placeholder = @"work email";
        _companyPhone.placeholder = @"work phone";
        _companyType.placeholder = @"employee title";
        _profileTag = 2;
    }
    
    
}

-(IBAction)registerUser:(id)sender {
    if([_usernameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reenterPassword.text isEqualToString:@""] || [_companyName.text isEqualToString:@""] || [_companyEmail.text isEqualToString:@""] || [_companyPhone.text isEqualToString:@""] || [_companyType.text isEqualToString:@""] || _profileTag == 0)
    {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"You must complete all fields"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
//        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//        [vc presentViewController:error animated:YES completion:nil];
    } else {
        [self checkPasswordsMatch];
    }
}

-(void) checkPasswordsMatch {
    if([_passwordField.text isEqualToString:_reenterPassword.text]) {
        [self registerNewUser];
    } else {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Passwords don't match"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
//        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//        [vc presentViewController:error animated:YES completion:nil];
    }
}

-(void) registerNewUser {
    
    NSString *passwordKey = [NSString stringWithFormat:@"%@-%@",_passwordField.text,_usernameField.text];
    NSString *companyKey = [NSString stringWithFormat:@"company-%@",_usernameField.text];
    NSString *directorKey = [NSString stringWithFormat:@"director-%@",_usernameField.text];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:_usernameField.text forKey:_usernameField.text];
    [defaults setObject:_passwordField.text forKey:passwordKey];
    [defaults setBool:YES forKey:@"registered"];
    
    [defaults synchronize];
    
    if(_profileTag == 1) {
        [[NSUserDefaults standardUserDefaults] setObject:_usernameField.text forKey:companyKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else if (_profileTag == 2) {
        [[NSUserDefaults standardUserDefaults] setObject:_usernameField.text forKey:directorKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    UIAlertController *success = [UIAlertController
                                      alertControllerWithTitle:@"Success"
                                      message:@"You've registered as a new user"
                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        [self goBack];
    }];
        [success addAction:okAction];
        [self presentViewController: success animated: YES completion:nil];
    
}

-(void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



@end
