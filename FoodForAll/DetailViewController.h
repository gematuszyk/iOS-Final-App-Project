//
//  DetailViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/20/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//



#import <UIKit/UIKit.h>

#import <Stripe/Stripe.h>

typedef NS_ENUM(NSInteger, STPBackendChargeResult) {
    STPBackendChargeResultSuccess,
    STPBackendChargeResultFailure,
};

typedef void (^STPTokenSubmissionHandler)(STPBackendChargeResult status, NSError *error);

@protocol STPBackendCharging <NSObject>

- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion;

@end

@interface DetailViewController : UITableViewController



@property (weak, nonatomic) IBOutlet UILabel *foodBankLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyRaised;
@property (weak, nonatomic) NSString *foodBankString;
@property (weak, nonatomic) NSString *moneyRaisedString;
@property (assign, nonatomic) NSInteger amountDonated;
@property (assign, nonatomic) NSString* frequency;
@property (assign, nonatomic) NSString* amountString;

@property (assign, nonatomic) NSInteger finalAmount;

@property (weak, nonatomic) IBOutlet UITextField *amountText;

//donation info
- (IBAction)amountClicked:(id)sender;
- (IBAction)frequencyClicked:(id)sender;
- (IBAction)ClickBtn:(UIButton *)sender;

//contact info
@property (weak, nonatomic) IBOutlet UIButton *buttonContinue;

//billing info
@property (weak, nonatomic) IBOutlet UIButton *ten;
@property (weak, nonatomic) IBOutlet UIButton *twenty;
@property (weak, nonatomic) IBOutlet UIButton *fifty;
@property (weak, nonatomic) IBOutlet UIButton *hundred;
@property (weak, nonatomic) IBOutlet UIButton *twofifty;
@property (weak, nonatomic) IBOutlet UIButton *onetime;
@property (weak, nonatomic) IBOutlet UIButton *weekly;
@property (weak, nonatomic) IBOutlet UIButton *monthly;
@property (weak, nonatomic) IBOutlet UIButton *quarterly;
@property (weak, nonatomic) IBOutlet UIButton *annually;






- (IBAction)back:(id)sender;

@end
