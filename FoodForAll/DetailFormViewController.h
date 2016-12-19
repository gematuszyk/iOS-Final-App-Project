//
//  DetailFormViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 12/3/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailFormViewController : UITableViewController <UITextViewDelegate>

@property (assign, nonatomic) NSString *dateString;
@property (assign, nonatomic) NSString *timeString;


@property (weak, nonatomic) IBOutlet UITextField *directorName;
@property (weak, nonatomic) IBOutlet UITextField *deliveryDate;
@property (weak, nonatomic) IBOutlet UITextField *deliveryTime;
@property (weak, nonatomic) IBOutlet UITextField *deliveryLocation;
@property (weak, nonatomic) IBOutlet UITextField *deliveryAmount;
@property (weak, nonatomic) IBOutlet UITextView *addInfo;

@property (strong , nonatomic) NSMutableDictionary *dict;

@end
