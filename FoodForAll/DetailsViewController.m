//
//  DetailsViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/21/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//
#import "DetailsViewController.h"
#import "FSCalendarExtensions.h"

@interface DetailsViewController () <FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
{
    NSMutableArray *pickerArray;
    NSMutableDictionary *_tableData;
    NSMutableArray *pickerData;
}

@property (weak, nonatomic) FSCalendar *calendar;

@property (weak, nonatomic) UILabel *eventLabel;

@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *formatter;

@end


@implementation DetailsViewController

- (IBAction)returnBack:(id)sender {
    
    if(![_titleStr isEqualToString:@""]) {
         [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        //alert controller
    }
    
}


- (void)setDetailItem:(Note *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    if(self.detailItem) {
        NSInteger row = [_picker selectedRowInComponent:0];
        NSString *str = [pickerArray objectAtIndex:row];
        self.tableTitle.text = self.detailItem.note;
        str = self.detailItem.time;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 350)];
    calendar.dataSource = self;
    calendar.delegate = self;
    [_scroll addSubview:calendar];
    self.calendar = calendar;
    //calendar.scopeGesture.enabled = YES;
    calendar.swipeToChooseGesture.enabled = YES;
    calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
    calendar.allowsMultipleSelection = NO;
    
    _calendar.appearance.weekdayTextColor = [UIColor colorWithRed:(109/255.0)  green:(173/255.0)  blue:(169/255.0)  alpha:1.0];
    _calendar.appearance.headerTitleColor = [UIColor colorWithRed:(31/255.0)  green:(47/255.0)  blue:(62/255.0)  alpha:1.0];
    _calendar.appearance.selectionColor = [UIColor colorWithRed:(109/255.0)  green:(173/255.0)  blue:(169/255.0)  alpha:1.0];
    _calendar.appearance.todayColor = [UIColor orangeColor];
    _calendar.appearance.todaySelectionColor = [UIColor blackColor];
    _calendar.calendarHeaderView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    _calendar.calendarWeekdayView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    _calendar.today = nil; // Hide the today circle

    UIView *myBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 350, [[UIScreen mainScreen] bounds].size.width, 400)];
    myBox.backgroundColor = [UIColor darkGrayColor];
    [_scroll insertSubview:myBox atIndex:0];
    
    
    UIView *myBox3  = [[UIView alloc] initWithFrame:CGRectMake(0, 350, [[UIScreen mainScreen] bounds].size.width, 30)];
    myBox3.backgroundColor = [UIColor colorWithRed:(200/255.0)  green:(200/255.0)  blue:(200/255.0)  alpha:1.0];
    myBox3.alpha = 0.5;
    [_scroll insertSubview:myBox3 atIndex:1];
    
    UIView *myBox4  = [[UIView alloc] initWithFrame:CGRectMake(190, 404, 110, 134)];
    myBox4.backgroundColor = [UIColor clearColor];
    myBox4.layer.borderColor = [UIColor colorWithRed:(200/255.0)  green:(200/255.0)  blue:(200/255.0)  alpha:1.0].CGColor;
    myBox4.layer.borderWidth = 2.0;
    myBox4.alpha = 0.5;
    [_scroll insertSubview:myBox4 atIndex:1];

    //[self.view insertSubview:_picker atIndex:3];
    
    _submitButton.layer.cornerRadius = 2;
    _submitButton.layer.borderWidth = 1;
    _submitButton.layer.borderColor = [UIColor whiteColor].CGColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Schedule a Call", @"");
    [label sizeToFit];
}

//  picker methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerArray.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    return pickerArray[row];
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *title = pickerArray[row];
    NSAttributedString *attString =
    [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    return attString;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove seperator inset
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    // Prevent the cell from inheriting the Table View's margin settings
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:NO];
//    }
//    
//    // Explictly set your cell's layout margins
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

    //  calendar methods

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date
{
    pickerArray = [[NSMutableArray alloc]init];
    NSMutableDictionary *savedDict = [[NSUserDefaults standardUserDefaults]objectForKey:@"tableData"];
    _tableData = [[NSMutableDictionary alloc]initWithDictionary:savedDict];
    //_selectTag = 1;
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateFormat = @"yyyy/MM/dd";
    _dateStr = [self.formatter stringFromDate:date];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    //_dayAdd=day;
    _monthStr = [self convertMonth:month];
    _dayStr = [NSString stringWithFormat:@"%ld",(long)day];
    _yearStr = [NSString stringWithFormat:@"%ld",(long)year];
    _tableTitle.text =[NSString stringWithFormat:@"%@ %@, %@",_monthStr, _dayStr,_yearStr];
    _titleStr = _tableTitle.text;
    //NSMutableArray *pickerArray = [[NSMutableArray alloc]init];
    NSArray *keys = [_tableData allKeys];
    for(NSString *key in keys) {
        if([key containsString:_titleStr]) {
            [pickerArray addObject:[_tableData objectForKey:key]];
        }
    }
    [_picker reloadAllComponents];
    //[self.tableView reloadData];
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


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSInteger row = [_picker selectedRowInComponent:0];
    NSString *str = [pickerArray objectAtIndex:row];
    Note *currentNote = [[Note getAllNotes] objectAtIndex:[Note getCurrentNoteIndex]];
    currentNote.note = self.tableTitle.text;
    currentNote.time = str;
    [[Note getAllNotes] setObject:currentNote atIndexedSubscript:[Note getCurrentNoteIndex]];
    if ([self.tableTitle.text isEqualToString:@""] || [str isEqualToString:@""] ) {
        [[Note getAllNotes] removeObjectAtIndex:[Note getCurrentNoteIndex]];
    }
    [Note saveNotes];
    [[Note getTable] reloadData];

}
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







@end
