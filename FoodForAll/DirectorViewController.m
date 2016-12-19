//
//  DirectorViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 12/1/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "DirectorViewController.h"
#import "FSCalendarExtensions.h"

@interface DirectorViewController () <FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
{
    NSArray *_pickerData;
}

@property (weak, nonatomic) FSCalendar *calendar;

@property (weak, nonatomic) UILabel *eventLabel;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *formatter;

@end

@implementation DirectorViewController

@synthesize tableView, tableData;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerData = @[@"12:00am", @"12:30pm", @"1:00pm", @"1:30pm",@"2:00pm",@"2:30pm",@"3:00pm",@"3:30pm",@"4:00pm",@"4:30pm",@"5:00pm",@"5:30pm",@"6:00pm",@"6:30pm",@"7:00pm",@"7:30pm",@"8:00pm",@"8:30pm",@"9:00pm",@"9:30pm",@"10:00pm",@"10:30pm",@"11:00pm",@"11:30pm",@"12:00pm",@"12:30am",@"1:00am",@"1:30am",@"2:00am",@"2:30am",@"3:00am",@"3:30am",@"4:00am",@"4:30am",@"5:00am",@"5:30am",@"6:00am",@"6:30am",@"7:00am",@"7:30am",@"8:00am",@"8:30am",@"9:00am",@"9:30am",@"10:00am",@"10:30am",@"11:00am",@"11:30am"];

    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Create your Schedule", @"");
    [label sizeToFit];
    
    _c =0;
    _tagToAdd=0;
    _sortTags = [[NSMutableArray alloc]init];

    UIView *myBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 350, [[UIScreen mainScreen] bounds].size.width, 400)];
    myBox.backgroundColor = [UIColor darkGrayColor];
    [_scroll insertSubview:myBox atIndex:0];
    
    UIView *myBox3  = [[UIView alloc] initWithFrame:CGRectMake(0, 350, [[UIScreen mainScreen] bounds].size.width, 30)];
    myBox3.backgroundColor = [UIColor colorWithRed:(200/255.0)  green:(200/255.0)  blue:(200/255.0)  alpha:1.0];
    myBox3.alpha = 0.5;
    [_scroll insertSubview:myBox3 atIndex:1];
    
    UIView *myBox4  = [[UIView alloc] initWithFrame:CGRectMake(15, 404, 104, 123)];
    myBox4.backgroundColor = [UIColor clearColor];
    myBox4.layer.borderColor = [UIColor colorWithRed:(200/255.0)  green:(200/255.0)  blue:(200/255.0)  alpha:1.0].CGColor;
    myBox4.layer.borderWidth = 2.0;
    myBox4.alpha = 0.5;
    [_scroll insertSubview:myBox4 atIndex:1];
    
    self.picker.dataSource = self;
    self.picker.delegate = self;

    
    _addDate.layer.borderWidth = 1;
    _addDate.layer.borderColor = [UIColor whiteColor].CGColor;
    
    _selectTag = 0;
    
    //[self.detailDescriptionLabel becomeFirstResponder];
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 350)];
    calendar.dataSource = self;
    calendar.delegate = self;
    [_scroll addSubview:calendar];
    self.calendar = calendar;
    calendar.scopeGesture.enabled = YES;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
    calendar.allowsMultipleSelection = NO;
    
    _calendar.appearance.weekdayTextColor = [UIColor colorWithRed:(109/255.0)  green:(173/255.0)  blue:(169/255.0)  alpha:1.0];
    _calendar.appearance.headerTitleColor = [UIColor colorWithRed:(109/255.0)  green:(173/255.0)  blue:(169/255.0)  alpha:1.0];
    _calendar.appearance.selectionColor = [UIColor colorWithRed:(109/255.0)  green:(173/255.0)  blue:(169/255.0)  alpha:1.0];
    _calendar.appearance.todayColor = [UIColor orangeColor];
    _calendar.appearance.todaySelectionColor = [UIColor blackColor];
    
    _calendar.calendarHeaderView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    _calendar.calendarWeekdayView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    _calendar.today = nil; // Hide the today circle
    
    _dateTime = @" - ";
    tableData = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"tableData"]];


}

    //  picker methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = _pickerData[row];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

    //  table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * keys;
    NSMutableDictionary *tableD = [[NSMutableDictionary alloc]initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"tableData"]];
    if(tableD != nil) {
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    keys = [tableD allKeys];
    NSString *getTitle = [[NSUserDefaults standardUserDefaults]objectForKey:@"title"];
    for(NSString* key in keys){
        if(getTitle != nil) {
            if ([key containsString:getTitle]) {
                [matches addObject:key];
            }
        }
    }return [matches count];
    }else return 0;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"timeCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSMutableArray * keys = [[NSMutableArray alloc]initWithArray:[[tableData allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)]];
    //keys = [_tableData allKeys];
    NSString *getTitle = [[NSUserDefaults standardUserDefaults]objectForKey:@"title"];
    NSMutableArray *matches = [[NSMutableArray alloc]init];
    NSMutableArray *finalArray = [[NSMutableArray alloc]init];
    for(NSString* key in keys){
        if(getTitle != nil) {
            if ([key containsString:getTitle]) {
                [matches addObject:key];
            }
        }
    }
    NSMutableArray *array2 = [[NSMutableArray alloc]init];
    NSMutableArray *getSortTags = [[NSMutableArray alloc]init];
    getSortTags = [[NSUserDefaults standardUserDefaults]objectForKey:@"sortTags"];
    NSString *firstHalf2, *secondHalf2, *thirdHalf2;
    NSMutableArray *array3 = [[NSMutableArray alloc]init];
    for(id stuff in matches) {
        if(![finalArray containsObject:stuff]) {
            [finalArray addObject:stuff];
        }
    }
    for(id word in getSortTags) {
        NSArray *substrings2 = [word componentsSeparatedByString:@"-"];
        firstHalf2 =[substrings2 objectAtIndex:0];
        secondHalf2 =[substrings2 objectAtIndex:1];
        thirdHalf2 =[substrings2 objectAtIndex:2];
        NSString *addTitle = [NSString stringWithFormat:@"%@-%@",firstHalf2,secondHalf2];
        if([firstHalf2 isEqualToString:getTitle] && ![array2 containsObject:addTitle]) {
            [array2 addObject:addTitle];
        }
    }
    
    NSArray* reversed = [[array2 reverseObjectEnumerator] allObjects];
    
    [array2 removeAllObjects];
    for(NSString *obj in reversed) {
        [array3 addObject:obj];
    }
    for(NSString *obj in array3) {
        [array2 addObject:obj];
    }
    for(id match in matches) {
        if(![array2 containsObject:match] && [match containsString:getTitle]) {
            [array2 addObject:match];
        }
    }
    [[NSUserDefaults standardUserDefaults]setObject:array2 forKey:@"array2"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    cell.textLabel.text = [tableData objectForKey:[array2 objectAtIndex:indexPath.row]];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *secondHalf2;
    NSString *path = [NSString stringWithFormat:@"%@",indexPath];
    NSArray *substrings2 = [path componentsSeparatedByString:@"- "];
    secondHalf2 =[substrings2 objectAtIndex:1];
    NSInteger index = [secondHalf2 integerValue];
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"array2"]];
    NSString *time = [array objectAtIndex:index];
    [[NSUserDefaults standardUserDefaults]setObject:time forKey:@"time"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"index"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString *time = [[NSUserDefaults standardUserDefaults]objectForKey:@"time"];
//    NSInteger index = [[NSUserDefaults standardUserDefaults]integerForKey:@"index"];
//    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"array2"]];
//   // [tableData removeObjectForKey:time];
//    NSLog(@"HERE   %@",[tableData objectForKey:time]);
//    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
//        [tableData removeObjectForKey:time];
//        [self.tableView reloadData];
//       // [array removeObject:time];
////        [self.tableView deleteRowsAtIndexPaths:@[indexPath+1]withRowAnimation:UITableViewRowAnimationFade];
//    }];
//    deleteAction.backgroundColor = [UIColor redColor];
//    return @[deleteAction];
//}

    //  calendar methods

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    NSMutableDictionary *savedDict = [[NSUserDefaults standardUserDefaults]objectForKey:@"tableData"];
    tableData = [[NSMutableDictionary alloc]initWithDictionary:savedDict];
    _selectTag = 1;
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"yyyy/MM/dd";
    _dateString = [self.formatter stringFromDate:date];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    _dayAdd=day;
    _monthString = [self convertMonth:month];
    _dayString = [NSString stringWithFormat:@"%d",day];
    _yearString = [NSString stringWithFormat:@"%d",year];
    _tableTitle.text =[NSString stringWithFormat:@"%@ %@, %@",_monthString, _dayString,_yearString];
    _titleNew = _tableTitle.text;
    [[NSUserDefaults standardUserDefaults]setObject:_titleNew forKey:@"title"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self.tableView reloadData];
}

- (IBAction)insertTime:(id)sender {
    NSInteger row;
    NSString *str;
    if(_selectTag == 1) {
        row = [_picker selectedRowInComponent:0];
        str = [_pickerData objectAtIndex:row];
        _dateTime = [NSString stringWithFormat:@"%@-%@",_titleNew,str];
        if ( [tableData objectForKey:_dateTime] != nil ) {
            UIAlertController *error = [UIAlertController
                                        alertControllerWithTitle:@"Error"
                                        message:@"Selected Time is already in table"
                                        preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [error addAction:okAction];
            [self presentViewController: error animated: YES completion:nil];
        } else {
            if(_c == 0) {
                _tagToAdd=1;
            }if(_c==_dayAdd){
                _tagToAdd++;
            }if(_c!=0 && _c!=_dayAdd){
                _tagToAdd=1;
            }
            _c=_dayAdd;
            _tagString = [NSString stringWithFormat:@"%@-%d",_dateTime,_tagToAdd];
            [_sortTags addObject:_tagString];
            [[NSUserDefaults standardUserDefaults]setObject:_sortTags forKey:@"sortTags"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [tableView beginUpdates];
            [tableData setObject:str forKey:_dateTime];
            [[NSUserDefaults standardUserDefaults]setObject:tableData forKey:@"tableData"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSArray *paths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
            [[self tableView] insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationTop];
            [tableView endUpdates];
        }
    } else {
        UIAlertController *error = [UIAlertController
                                    alertControllerWithTitle:@"Error"
                                    message:@"Please select a date from the calendar"
                                    preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [error addAction:okAction];
        [self presentViewController: error animated: YES completion:nil];
    }
}

-(NSString *)convertMonth:(NSInteger)month {
    NSString *monthText;
    if(month == 1) {monthText = @"January";}
    else if(month == 2) {monthText = @"February";}
    else if(month == 3) {monthText = @"March";}
    else if(month == 4) {monthText = @"April";}
    else if(month == 5) {monthText = @"May";}
    else if(month == 6) {monthText = @"June";}
    else if(month == 7) {monthText = @"July";}
    else if(month == 8) {monthText = @"August";}
    else if(month == 9) {monthText = @"September";}
    else if(month == 10) {monthText = @"October";}
    else if(month == 11) {monthText = @"November";}
    else if(month == 12) {monthText = @"December";}
    return monthText;
}

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.formatter dateFromString:@"2016-07-08"];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.formatter dateFromString:@"2018-03-31"];
}
//
//- (BOOL)calendar:(FSCalendar *)calendar hasEventForDate:(NSDate *)date
//{
//    return shouldShowEventDot;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutBut:(id)sender {
//    [[NSUserDefaults standardUserDefaults]setObject:_tableData forKey:@"tableData"];
//    [[NSUserDefaults standardUserDefaults]synchronize];

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
