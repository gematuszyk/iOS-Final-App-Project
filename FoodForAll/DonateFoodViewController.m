//
//  DonateFoodViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "DonateFoodViewController.h"
#import "SignUpViewController.h"
#import "MasterViewController.h"
#import "KeychainItemWrapper.h"

#import "SWRevealViewController.h"

@implementation DonateFoodViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    
    //  custom hamburger nav bar button
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    btnNext1.frame = CGRectMake(90, 100, 30, 30);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self.navigationController.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:19.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"FoodForAll", @"");
    [label sizeToFit];
            
    _companyButton.layer.cornerRadius = 12;
    _companyButton.layer.borderWidth = 1;
    _companyButton.layer.borderColor = [UIColor whiteColor].CGColor;
    _directorButton.layer.cornerRadius = 12;
    _directorButton.layer.borderWidth = 1;
    _directorButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _usernameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _roleTag = 0;
    
    
    UIView *myBox2  = [[UIView alloc] initWithFrame:CGRectMake(24, 146, ([[UIScreen mainScreen] bounds].size.width -48), [[UIScreen mainScreen] bounds].size.width-108)];
    myBox2.backgroundColor = [[UIColor alloc]initWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [self.view insertSubview:myBox2 atIndex:0];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"new.png"]];
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    //ADD BLUR EFFECT VIEW IN MAIN VIEW
    [self.view insertSubview:blurEffectView atIndex:0];
}

- (IBAction)rolePressed:(UIButton *)button {
    if(button.tag == 1) {
        _directorButton.backgroundColor = [UIColor clearColor];
        _companyButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:181/255.0 blue:176/255.0 alpha:1.0];
        _roleTag = 1;
    } else if(button.tag == 2) {
        _companyButton.backgroundColor = [UIColor clearColor];
        _directorButton.backgroundColor = [UIColor colorWithRed:110/255.0 green:181/255.0 blue:176/255.0 alpha:1.0];
        _roleTag = 2;
    }
}

- (BOOL)revealControllerPanGestureShouldBegin:(SWRevealViewController *)revealController
{
    float velocity = [revealController.panGestureRecognizer velocityInView:self.view].x;
    if (velocity < 0 && self.revealViewController.frontViewPosition == FrontViewPositionLeft)
        return NO;
    else
        return YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)registerBtnPressed:(id)sender {
    [self performSegueWithIdentifier:@"signup" sender:nil];


 } 




-(IBAction)loginUser:(id)sender {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *passwordKey = [defaults objectForKey:[NSString stringWithFormat:@"%@-%@",_passwordField.text,_usernameField.text]];

    if([_usernameField.text isEqualToString:[defaults objectForKey:_usernameField.text]] && [_passwordField.text isEqualToString:passwordKey]) {
        if(_roleTag == 1 && [_usernameField.text isEqualToString:[defaults objectForKey:[NSString stringWithFormat:@"company-%@",_usernameField.text]]]) {
            [self performSegueWithIdentifier:@"login" sender:nil];
        } else if (_roleTag == 2 && [_usernameField.text isEqualToString:[defaults objectForKey:[NSString stringWithFormat:@"director-%@",_usernameField.text]]]) {
            [self performSegueWithIdentifier:@"director" sender:nil];
        }
    }else {
        UIAlertController *error = [UIAlertController
                                      alertControllerWithTitle:@"Error"
                                      message:@"Password or username are incorrect"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [vc presentViewController:error animated:YES completion:nil];

        
        

    }
}

@end
