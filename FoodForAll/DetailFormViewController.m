//
//  DetailFormViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 12/3/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "DetailFormViewController.h"

@implementation DetailFormViewController

@synthesize addInfo, dict;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *clickedName = [[NSUserDefaults standardUserDefaults]objectForKey:@"sender"];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:17.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Add details from your call", @"");
    [label sizeToFit];
    
    
    dict = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults]objectForKey:@"dictionary"]];
    if(dict != nil) {
         NSArray *keys = [dict allKeys];
        NSMutableArray *getArray = [[NSMutableArray alloc]init];
        for(NSString *key in keys) {
            if([key isEqualToString:clickedName]) {
                getArray = [dict objectForKey:key];
                _directorName.text = [getArray objectAtIndex:0];
                _deliveryDate.text = [getArray objectAtIndex:1];
                _deliveryTime.text = [getArray objectAtIndex:2];
                _deliveryLocation.text = [getArray objectAtIndex:3];
                _deliveryAmount.text = [getArray objectAtIndex:4];
                addInfo.text = [getArray objectAtIndex:5];
            }
        }
    }
   
    
    addInfo.delegate = self;
    if(addInfo.text == nil) {
        addInfo.text = @"Additional information";
    }
    addInfo.textColor = [UIColor lightGrayColor];
    addInfo.layer.borderWidth = 1;
    addInfo.layer.borderColor = [[UIColor grayColor] CGColor];
    addInfo.layer.cornerRadius = 4;
    
    _directorName.clearButtonMode = UITextFieldViewModeWhileEditing;
    _deliveryDate.clearButtonMode = UITextFieldViewModeWhileEditing;
    _deliveryTime.clearButtonMode = UITextFieldViewModeWhileEditing;
    _deliveryAmount.clearButtonMode = UITextFieldViewModeWhileEditing;
    _deliveryLocation.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Additional information"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor]; //optional
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Additional information";
        textView.textColor = [UIColor lightGrayColor]; //optional
    }
    [textView resignFirstResponder];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    if(section ==0) {
        NSString *name = [NSString stringWithFormat:@"%@\nPhone: 518.234.4389",[[NSUserDefaults standardUserDefaults]objectForKey:@"sender"]];
        sectionName = name;
    }
    return sectionName;
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitBtn:(id)sender {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSString *name = [[NSUserDefaults standardUserDefaults]objectForKey:@"sender"];
    if([_directorName.text isEqualToString:@""]) {
        [array addObject:@""];
    } else {
        [array addObject:_directorName.text];
    }if([_deliveryDate.text isEqualToString:@""]) {
        [array addObject:@""];
    } else {
        [array addObject:_deliveryDate.text];
    }if([_deliveryTime.text isEqualToString:@""]) {
        [array addObject:@""];
    } else {
        [array addObject:_deliveryTime.text];
    }if([_deliveryLocation.text isEqualToString:@""]) {
        [array addObject:@""];
    } else {
        [array addObject:_deliveryLocation.text];
    }if([_deliveryAmount.text isEqualToString:@""]) {
        [array addObject:@""];
    } else {
        [array addObject:_deliveryAmount.text];
    }if([addInfo.text isEqualToString:@""]) {
        [array addObject:@""];
    } else {
        [array addObject:addInfo.text];
    }
    [dict setObject:array forKey:name];
    [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"dictionary"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)backButtonP:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
