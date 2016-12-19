//
//  DetailViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/20/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "DetailViewController.h"
#import "DonateTableViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "PaymentViewController.h"
#import "Stripe/Stripe.h"
#import "Constants.h"

@interface DetailViewController()<PaymentViewControllerDelegate, PKPaymentAuthorizationViewControllerDelegate>
{
    NSMutableDictionary *addedDict;
//    SystemSoundID applause;
//    SystemSoundID groan;
}
@property (nonatomic) BOOL applePaySucceeded;
@property (nonatomic) NSError *applePayError;

@end

@implementation DetailViewController

@synthesize foodBankLabel,foodBankString, moneyRaised, moneyRaisedString, amountDonated, frequency, finalAmount;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.foodBankLabel.text = foodBankString;
    self.moneyRaised.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"moneyStr"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:21.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Donation Form", @"");
    [label sizeToFit];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];//[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self setButton:_ten];
    [self setButton:_twofifty];
    [self setButton:_hundred];
    [self setButton:_fifty];
    [self setButton:_twenty];
    [self setButton:_onetime];
    [self setButton:_weekly];
    [self setButton:_quarterly];
    [self setButton:_monthly];
    [self setButton:_annually];
    
    [_amountText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [_buttonContinue setTitleColor:[UIColor colorWithRed:94/255.0 green:157/255.0 blue:152/255.0 alpha:1.0] forState:UIControlStateNormal];
    _ten.backgroundColor = [UIColor clearColor];
    _twofifty.backgroundColor = [UIColor clearColor];
    _twenty.backgroundColor = [UIColor clearColor];
    _fifty.backgroundColor = [UIColor clearColor];
    _hundred.backgroundColor = [UIColor clearColor];
    _onetime.backgroundColor = [UIColor clearColor];
    _annually.backgroundColor = [UIColor clearColor];
    _weekly.backgroundColor = [UIColor clearColor];
    _monthly.backgroundColor = [UIColor clearColor];
    [_ten setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_twenty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_twofifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_hundred setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_fifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_onetime setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_annually setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_weekly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_monthly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];

}

-(void)textFieldDidChange :(UITextField *) textField{
    NSString *textChange = textField.text;
    amountDonated = [textChange integerValue];
    
}

-(void)setButton: (UIButton *)button{
    [button setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    button.layer.cornerRadius = 4;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0].CGColor;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.backgroundColor = [UIColor lightGrayColor];
    if ([cell respondsToSelector:@selector(tintColor)]) {
            // self.tableview
            CGFloat cornerRadius = 8.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 6, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
        layer.fillColor = [UIColor whiteColor].CGColor;

        
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+5, bounds.size.height-lineHeight, bounds.size.width-5, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    
}


- (IBAction)amountClicked:(id)sender {
    if([[sender currentTitle] isEqualToString:@"$10"]) {
        amountDonated = 10;
    }else if([[sender currentTitle] isEqualToString:@"$25"]) {
        amountDonated = 25;
    }else if([[sender currentTitle] isEqualToString:@"$50"]) {
        amountDonated = 50;
    }else if([[sender currentTitle] isEqualToString:@"$100"]) {
        amountDonated = 100;
    }else if([[sender currentTitle] isEqualToString:@"$250"]) {
        amountDonated = 250;
    } 
    
}

- (IBAction)textBox:(id)sender {
    if(![_amountText.text isEqualToString:@""]) {
        amountDonated =  [_amountText.text intValue];
    }
}

- (IBAction)frequencyClicked:(id)sender {
    frequency = [sender currentTitle];
}



- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    //[self performSegueWithIdentifier:@"donated" sender:addedDict];
}


-(IBAction)ClickBtn:(UIButton *)sender
{
    if(sender.tag==1) {
        [_twenty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_twofifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_fifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_hundred setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _twenty.backgroundColor = [UIColor clearColor];
        _twofifty.backgroundColor = [UIColor clearColor];
        _fifty.backgroundColor = [UIColor clearColor];
        _hundred.backgroundColor = [UIColor clearColor];
        [_ten setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _ten.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    } else if(sender.tag==2) {
        [_ten setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_twofifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_fifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_hundred setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _ten.backgroundColor = [UIColor clearColor];
        _twofifty.backgroundColor = [UIColor clearColor];
        _fifty.backgroundColor = [UIColor clearColor];
        _hundred.backgroundColor = [UIColor clearColor];
        [_twenty setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _twenty.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    } else if(sender.tag==3) {
        [_ten setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_twenty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_twofifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_hundred setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _twenty.backgroundColor = [UIColor clearColor];
        _twofifty.backgroundColor = [UIColor clearColor];
        _ten.backgroundColor = [UIColor clearColor];
        _hundred.backgroundColor = [UIColor clearColor];
        [_fifty setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _fifty.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    } else if(sender.tag==4) {
        [_twenty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_twofifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_fifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_ten setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _twenty.backgroundColor = [UIColor clearColor];
        _twofifty.backgroundColor = [UIColor clearColor];
        _fifty.backgroundColor = [UIColor clearColor];
        _ten.backgroundColor = [UIColor clearColor];
        [_hundred setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _hundred.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    }else if(sender.tag==5) {
        [_twenty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_ten setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_fifty setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_hundred setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _twenty.backgroundColor = [UIColor clearColor];
        _ten.backgroundColor = [UIColor clearColor];
        _fifty.backgroundColor = [UIColor clearColor];
        _hundred.backgroundColor = [UIColor clearColor];
        [_twofifty setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _twofifty.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    } else if(sender.tag==6) {
        [_weekly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_monthly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_annually setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _weekly.backgroundColor = [UIColor clearColor];
        _monthly.backgroundColor = [UIColor clearColor];
        _annually.backgroundColor = [UIColor clearColor];
        [_onetime setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _onetime.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    } else if(sender.tag==7) {
        [_onetime setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_annually setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_monthly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _onetime.backgroundColor = [UIColor clearColor];
        _annually.backgroundColor = [UIColor clearColor];
        _monthly.backgroundColor = [UIColor clearColor];
        [_weekly setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _weekly.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    } else if(sender.tag==8) {
        [_onetime setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_weekly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_annually setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _onetime.backgroundColor = [UIColor clearColor];
        _weekly.backgroundColor = [UIColor clearColor];
        _annually.backgroundColor = [UIColor clearColor];
        [_monthly setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _monthly.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    }else if(sender.tag==10) {
        [_onetime setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_weekly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_monthly setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        _onetime.backgroundColor = [UIColor clearColor];
        _weekly.backgroundColor = [UIColor clearColor];
        _monthly.backgroundColor = [UIColor clearColor];
        [_annually setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _annually.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
    }

}

- (IBAction)continueButton:(id)sender {
    [sender setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
    [[NSUserDefaults standardUserDefaults]setInteger:amountDonated forKey:@"amountDonated"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]setObject:foodBankString forKey:@"foodBankString"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [self performSegueWithIdentifier:@"payment" sender:nil];
    
}





- (void)createBackendChargeWithToken:(STPToken *)token completion:(STPTokenSubmissionHandler)completion {
    
    if (!BackendChargeURLString) {
        NSError *error = [NSError
                          errorWithDomain:StripeDomain
                          code:STPInvalidRequestError
                          userInfo:@{
                                     NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Good news! Stripe turned your credit card into a token: %@ \nYou can follow the "
                                                                 @"instructions in the README to set up an example backend, or use this "
                                                                 @"token to manually create charges at dashboard.stripe.com .",
                                                                 token.tokenId]
                                     }];
        completion(STPBackendChargeResultFailure, error);
        return;
    }
    
    // This passes the token off to our payment backend, which will then actually complete charging the card using your Stripe account's secret key
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSString *urlString = [BackendChargeURLString stringByAppendingPathComponent:@"charge_card"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    NSString *postBody = [NSString stringWithFormat:@"stripe_token=%@&amount=%@", token.tokenId, @1000];
    NSData *data = [postBody dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request
                                                               fromData:data
                                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                          if (!error && httpResponse.statusCode != 200) {
                                                              error = [NSError errorWithDomain:StripeDomain
                                                                                          code:STPInvalidRequestError
                                                                                      userInfo:@{NSLocalizedDescriptionKey: @"There was an error connecting to your payment backend."}];
                                                          }
                                                          if (error) {
                                                              completion(STPBackendChargeResultFailure, error);
                                                          } else {
                                                              completion(STPBackendChargeResultSuccess, nil);
                                                          }
                                                      }];
    
    [uploadTask resume];
}





@end
