//
//  DonateTableViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/26/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DonateTableViewController : UITableViewController<UISearchBarDelegate>
//    NSDictionary *foodBanks;
//    NSArray *foodBankSectionTitles;
//    NSArray *foodBankTitles;
//}

@property (copy, nonatomic) NSString *foodBankName;

@property (strong, nonatomic) NSDictionary *foodBanks;
@property (strong, nonatomic) NSArray *foodBankSectionTitles;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property (strong, nonatomic) NSMutableArray *filteredTableData;


@property (nonatomic, assign) NSString *foodLabel;
@property (nonatomic, assign) NSString *raisedLabel;
@property (nonatomic, assign) BOOL isFiltered;
@property (nonatomic, strong) NSMutableArray *providerId;
@property (nonatomic, assign) BOOL shouldScrollToLastRow;

@property (nonatomic, assign) NSString *totalAmount;

@property (strong, nonatomic) NSMutableArray *money;

-(void)findLargestAmount;

@end
