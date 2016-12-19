//
//  MasterViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/21/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailsViewController.h"
#import "DetailFormViewController.h"
#import "Note.h"

@interface MasterViewController ()

//@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Note loadNotes];
    [Note setTable:self.tableView];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    addButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:19.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"Scheduled Calls", @"");
    [label sizeToFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    [[Note getAllNotes] insertObject:[Note new] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [Note setCurrentNoteIndex:0];
    [self performSegueWithIdentifier:@"showDetail" sender:self];

}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    
    if(indexPath.row % 2 == 0) {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:49/255.0 green:75/255.0 blue:99/255.0 alpha:1.0];
    } else {
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor colorWithRed:55/255.0 green:84/255.0 blue:112/255.0 alpha:1.0];
    }
}

#pragma mark - Segues

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = [NSString stringWithFormat:@"%@-%@",selectedCell.textLabel.text,selectedCell.detailTextLabel.text];
    [self performSegueWithIdentifier:@"detailForm" sender:cellText];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailsViewController *details = (DetailsViewController *)[[segue destinationViewController] topViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if(indexPath != nil ) {
            [Note setCurrentNoteIndex:(int)indexPath.row];
        }
        Note *object = [Note getAllNotes][[Note getCurrentNoteIndex]];
        [details setDetailItem:object];
    } else if([[segue identifier] isEqualToString:@"detailForm"]) {
        [[NSUserDefaults standardUserDefaults]setObject:sender forKey:@"sender"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
}


- (IBAction)logoutBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Note getAllNotes].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Note *object = [Note getAllNotes][indexPath.row];
    cell.textLabel.text = object.note;
    cell.detailTextLabel.text = object.time;
    return cell;
}



-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [[Note getAllNotes] removeObjectAtIndex:indexPath.row];
        [Note saveNotes];
        [tableView deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationFade];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction];
}




@end
