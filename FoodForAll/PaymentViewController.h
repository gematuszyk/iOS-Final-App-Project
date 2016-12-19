//
//  PaymentViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 12/15/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#ifndef PaymentViewController_h
#define PaymentViewController_h

#import <UIKit/UIKit.h>
#import <Stripe/Stripe.h>

@class PaymentViewController;

@protocol PaymentViewControllerDelegate<NSObject>

- (void)paymentViewController:(PaymentViewController *)controller didFinish:(NSError *)error;

@end

@interface PaymentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (nonatomic) NSDecimalNumber *amount;
@property (nonatomic, weak) id<STPBackendCharging> backendCharger;
@property (nonatomic, weak) id<PaymentViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phone;

@property (weak, nonatomic) IBOutlet UITextField *addressOne;
@property (weak, nonatomic) IBOutlet UITextField *addressTwo;
@property (weak, nonatomic) IBOutlet UITextField *city;
@property (weak, nonatomic) IBOutlet UITextField *state;
@property (weak, nonatomic) IBOutlet UITextField *zipcode;


@property (assign, nonatomic) NSString* frequency;
@property (assign, nonatomic) NSString* amountString;
@property (assign, nonatomic) NSInteger amountDonated;
@property (weak, nonatomic) NSString *foodBankString;
@property (assign, nonatomic) NSInteger finalAmount;
@property (weak, nonatomic) NSString *moneyRaisedString;


@end

#endif /* PaymentViewController_h */
