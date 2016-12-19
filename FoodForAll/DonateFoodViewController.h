//
//  DonateFoodViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DonateFoodViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (assign, nonatomic) NSInteger roleTag;

@property (weak, nonatomic) IBOutlet UIButton *companyButton;
@property (weak, nonatomic) IBOutlet UIButton *directorButton;
- (IBAction)rolePressed:(UIButton *)button;

-(IBAction)loginUser:(id)sender;
-(IBAction)registerBtnPressed:(id)sender;

@end
