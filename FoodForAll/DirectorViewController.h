//
//  DirectorViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 12/1/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSCalendar.h"

@interface DirectorViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate,UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *picker;


@property (weak, nonatomic) IBOutlet UIScrollView *scroll;

@property (assign, nonatomic) NSString *monthString;
@property (assign, nonatomic) NSString *dayString;
@property (assign, nonatomic) NSString *yearString;
@property (assign, nonatomic) NSString *timeString;

@property (assign, nonatomic) NSString *tagString;

@property (assign, nonatomic) NSString *dateString;
@property (assign, nonatomic) NSString *dateTime;
@property (assign, nonatomic) NSString *titleNew;

@property (assign, nonatomic) NSInteger selectTag;

@property (assign, nonatomic) NSInteger c;
@property (assign, nonatomic) NSInteger tagToAdd;
@property (assign, nonatomic) NSInteger dayAdd;

@property (strong , nonatomic) NSMutableArray *sortTags;
@property (strong , nonatomic) NSMutableArray *holdingArray;


@property (strong , nonatomic) NSMutableDictionary *tableData;

@property (weak, nonatomic) IBOutlet UILabel *tableTitle;


@property (weak, nonatomic) IBOutlet UIButton *addDate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)insertTime:(id)sender;

@end
