//
//  SignUpViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/10/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reenterPassword;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *companyEmail;
@property (weak, nonatomic) IBOutlet UITextField *companyPhone;
@property (weak, nonatomic) IBOutlet UITextField *companyType;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@property (weak, nonatomic) IBOutlet UIButton *companyBtn;
@property (weak, nonatomic) IBOutlet UIButton *directorBtn;

@property (assign, nonatomic) NSInteger profileTag;

- (IBAction)roleChosen:(id)sender;

-(IBAction)registerUser:(id)sender;



@end
