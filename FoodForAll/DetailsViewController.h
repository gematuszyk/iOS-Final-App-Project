//
//  DetailsViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/21/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "FSCalendar.h"


@interface DetailsViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

//@property (strong, nonatomic) NSMutableArray *pickerArray;

@property (assign, nonatomic) NSString *monthStr;
@property (assign, nonatomic) NSString *dayStr;
@property (assign, nonatomic) NSString *yearStr;
@property (assign, nonatomic) NSString *timeStr;
@property (assign, nonatomic) NSString *dateStr;

@property (assign, nonatomic) NSString *titleStr;

@property (weak, nonatomic) IBOutlet UILabel *tableTitle;

@property (strong, nonatomic) Note *detailItem;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
