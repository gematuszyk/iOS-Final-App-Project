//
//  NavigationTableViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "NavigationTableViewController.h"
#import "SWRevealViewController.h"
#import "FindFoodViewController.h"

@interface NavigationTableViewController ()

@end

@implementation NavigationTableViewController {
    NSArray *menu;
}

//-(id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:<#style#>];
//    if(self) {
//        //Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menu = @[@"home", @"first", @"second", @"third", @"fourth", @"fifth"];
    [self.tableView setSeparatorColor:[UIColor blackColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)addShadowToViewController:(UIViewController *)viewController
{
    [viewController.view.layer setCornerRadius:4];
    [viewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [viewController.view.layer setShadowOpacity:0.8];
    [viewController.view.layer setShadowOffset:CGSizeMake(-2,2)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return menu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = [menu objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    if (indexPath.row==0)
    {
        UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32,20,32,32)];
        [yourImageView setImage:[UIImage imageNamed:@"home.png"]];
        [cell.contentView addSubview:yourImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 30, 20)];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor    = [UIColor whiteColor];
        label.text = @"Home";
        [label setTextColor:[UIColor whiteColor]];
        [label sizeToFit];
        [cell.contentView addSubview:label];
    }
    if (indexPath.row==1)
    {
        UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32,20,32,32)];
        [yourImageView setImage:[UIImage imageNamed:@"money.png"]];
        [cell.contentView addSubview:yourImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27, 55, 30, 20)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(28, 68, 30, 20)];
        label.font = [UIFont boldSystemFontOfSize:12];
        label2.font = [UIFont boldSystemFontOfSize:12];
        label.textColor    = [UIColor whiteColor];
        label2.textColor    = [UIColor whiteColor];
        label.text = @"Donate";
        label2.text = @"Money";
        [label sizeToFit];
        [label2 sizeToFit];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:label2];
    }
    if (indexPath.row==2)
    {
        UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(33,20,32,32)];
        [yourImageView setImage:[UIImage imageNamed:@"apple.png"]];
        [cell.contentView addSubview:yourImageView];

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(27, 55, 30, 20)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(33, 68, 30, 20)];
        label.font = [UIFont boldSystemFontOfSize:12];
        label2.font = [UIFont boldSystemFontOfSize:12];
        label.textColor    = [UIColor whiteColor];
        label2.textColor    = [UIColor whiteColor];
        label.text = @"Donate";
        label2.text = @"Food";
        [label sizeToFit];
        [label2 sizeToFit];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:label2];
        
    }
    if (indexPath.row==3)
    {
        UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32,20,34,34)];
        [yourImageView setImage:[UIImage imageNamed:@"find.png"]];
        [cell.contentView addSubview:yourImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(29, 55, 28, 20)];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(18, 68, 30, 20)];
        label.font = [UIFont boldSystemFontOfSize:12];
        label2.font = [UIFont boldSystemFontOfSize:12];
        label.textColor    = [UIColor whiteColor];
        label2.textColor    = [UIColor whiteColor];
        label.text = @"Food a";
        label2.text = @"Food Bank";
        [label sizeToFit];
        [label2 sizeToFit];
        [cell.contentView addSubview:label];
        [cell.contentView addSubview:label2];
        
    }
    if (indexPath.row==4)
    {
        UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(32,20,31,31)];
        [yourImageView setImage:[UIImage imageNamed:@"about.png"]];
        [cell.contentView addSubview:yourImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(30, 60, 30, 20)];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor    = [UIColor whiteColor];
        label.text = @"About";
        [label sizeToFit];
        [cell.contentView addSubview:label];
    }
    if (indexPath.row==5)
    {
        UIImageView *yourImageView = [[UIImageView alloc] initWithFrame:CGRectMake(26,14,43,43)];
        [yourImageView setImage:[UIImage imageNamed:@"contact.png"]];
        [cell.contentView addSubview:yourImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(25, 60, 30, 20)];
        label.font = [UIFont boldSystemFontOfSize:12];
        label.textColor    = [UIColor whiteColor];
        label.text = @"Contact";
        [label sizeToFit];
        [cell.contentView addSubview:label];
    }



    // Configure the cell...
    
    return cell;
}







// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[menu objectAtIndex:indexPath.row] capitalizedString];
    [self addShadowToViewController:destViewController];

}

@end
