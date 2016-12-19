//
//  ContactViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "ContactViewController.h"

#import "SWRevealViewController.h"

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButton setTarget: self.revealViewController];
        [self.barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    //  custom hamburger nav bar button
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    btnNext1.frame = CGRectMake(90, 100, 30, 30);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    
    _emailBtn.layer.cornerRadius = 4;
    _emailBtn.layer.borderWidth = 1;
    _emailBtn.layer.borderColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0].CGColor;
    
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)sendEmail:(id)sender {
    _emailBtn.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
   [_emailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    NSString *emailTitle = @"Information Request";
    // Email Content
    NSString *messageBody = @" ";
    // To address
    NSArray *toRecipents = [NSArray arrayWithObject:@"foodforall.contact@gmail.com"];
//
//    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
//
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
