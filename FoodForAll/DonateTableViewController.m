//
//  DonateTableViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/26/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "DonateTableViewController.h"
#import "DetailViewController.h"
#import "SWRevealViewController.h"
#import "CustomCell.h"


@interface DonateTableViewController() {
    NSMutableDictionary *getDict;
}

@end

static NSString* modelLabel;


@implementation DonateTableViewController

@synthesize foodBankName, providerId, foodBanks, foodBankSectionTitles, foodLabel, raisedLabel, isFiltered, filteredTableData;


    -(void)viewWillAppear:(BOOL)animated{
        [self.tableView reloadData];
        [self findLargestAmount];
        [self.navigationController setToolbarHidden:YES];
    }
    
    - (void)viewDidLoad
    {
        self.searchBar.delegate = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:21.0];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = label;
        label.text = NSLocalizedString(@"Food Banks", @"");
        [label sizeToFit];
        
        UIButton *btnNext1 =[[UIButton alloc] init];
        [btnNext1 setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
        btnNext1.frame = CGRectMake(90, 100, 30, 30);
        UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
        [btnNext1 addTarget:self.navigationController.revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = btnNext;
        [super viewDidLoad];
        

        self.foodBanks = @{@"Alaska":@{@"Food Bank of Alaska":@10},
                           @"Alabama":@{@"Community Food Bank of Central Alabama":@10,
                                        @"Food Bank of North Alabama":@60,
                                        @"Montgomery Area Food Bank":@0,
                                        @"Feeding the Gulf Coast":@0},
                           @"Arkansas":@{@"Northwest Arkansas Food Bank":@30,
                                         @"River Valley Regional Food Bank":@0,
                                         @"Food Bank of Northeast Arkansas":@0,
                                         @"Arkansas Foodbank":@0,
                                         @"Harvest Texarkana Regional Food Bank":@0},
                           @"California":@{@"Food Bank of Contra Costa and Solano":@0,
                                           @"Community Food Bank":@0,
                                           @"FIND Food Bank":@0,
                                           @"Second Harvest Food Bank of Orange County":@0,
                                           @"Los Angeles Regional Food Bank":@0,
                                           @"Second Harvest Food Bank of San Joaquin and Stanislaus Counties":@0,
                                           @"Alammeda County Community Food Bank":@0,
                                           @"Food Share":@0,
                                           @"Feeding America Riverside San Bernardino Counties":@0,
                                           @"Placer Food Bank":@0,
                                           @"Food Bank for Monterey County":@0,
                                           @"Feeding San Diego":@0,
                                           @"SF-Marin Food Banks":@0,
                                           @"Second Harvest Food Bank of Santa Clara & San Mateo Counties":@0,
                                           @"Foodbank of Santa Barbara County":@0,
                                           @"Redwood Empire Food Bank":@0,
                                           @"Second Harvest Food Bank Santa Cruz County":@0},
                           @"Colorado":@{@"Care and Share Food Bank":@0,
                                         @"Food Bank of the Rockies":@0,
                                         @"Food Bank for Larimer County":@0,
                                         @"Weid Food Bank":@0,
                                         @"Community Food Share":@0},
                           @"Conneticut":@{@"Foodshare":@0,
                                         @"Connecticut Food Bank":@0},
                           @"D.C.":@{@"Capital Area Food Bank":@0},
                           @"Delaware":@{@"Food Bank of Delaware":@23},
                           @"Florida":@{@"Harry Chapin Food Bank of Southwest Florida":@0,
                                        @"Treasure Coast Food Bank":@0,
                                        @"Feeding Northeast Florida":@0,
                                        @"Second Harvest Food Bank of Central Florida":@0,
                                        @"Feeding South Florida":@0,
                                        @"All Faiths Food Bank":@0,
                                        @"America's Second Harvest of the Big Bend":@0,
                                        @"Feeding Tampa Bay":@0},
                           @"Georgia":@{@"Food Bank of Northeast Georgia":@80,
                                        @"Atlanta Community Food Bank":@35,
                                        @"Golden Harvest Food Bank":@0,
                                        @"Feeding the Valley Food Bank":@0,
                                        @"Middle Georgia Community Food Bank":@0,
                                        @"America's Second Harvest of Coastal Georgia":@0,
                                        @"Second Harvest of South Georgia":@0},
                           @"Hawaii":@{@"Hawaii Foodbank":@0},
                           @"Iowa":@{@"River Bend Food Bank":@0,
                                     @"Food Bank of Iowa":@0,
                                     @"HACAP Food Reservoir":@0,
                                     @"Northeast Iowa Food Bank":@0},
                           @"Idaho":@{@"The Idaho Foodbank":@0},
                           @"Illinois":@{@"Greater Chicago Food Depository":@0,
                                         @"Northern Illinois Food Bank":@34,
                                         @"Central Illinois Foodbank":@0,
                                         @"Eastern Illinois Foodbank":@0},
                           @"Indiana":@{@"Hoosier Hills Food Bank":@0,
                                        @"Tri-State Food Bank":@0,
                                        @"Community Harvest Food Bank of Northeast Indiana":@0,
                                        @"Food Bank of Northwest Indiana":@0,
                                        @"Gleaners Food Bank of Indiana":@0,
                                        @"Food Finders Food Bank":@56,
                                        @"Second Harvest Food Bank of East Central Indiana":@0,
                                        @"Food Bank of Nothern Indiana":@0,
                                        @"Terre Haute Catholic Charities Foodbank":@0},
                           @"Kansas":@{@"Kansas Food Bank":@0},
                           @"Kentucky":@{@"Feeding America, Kentucky's Heartland":@0,
                                         @"God's Pantry Food Bank":@0,
                                         @"Dare to Care Food Bank":@80},
                           @"Louisiana":@{@"Food Bank of Central Louisiana":@0,
                                          @"Greater Baton Rouge Food Bank":@0,
                                          @"Food Bank of Northeast Louisiana":@0,
                                          @"Second Harvest Food Bank of Greater New Orleans and Acadiana":@0,
                                          @"Food Bank of Northwest Louisiana":@0},
                           @"Massachusetts":@{@"The Greater Boston Food Bank":@0,
                                              @"The Food Bank of Western Massachusetts":@0,
                                              @"Worcester County Food Bank":@0,
                                              @"Community Food Share":@10},
                           @"Maryland":@{@"Maryland Food Bank":@0},
                           @"Maine":@{@"Good Shepherd Food Bank":@0},
                           @"Michigan":@{@"Food Gatherers":@0,
                                         @"Food Bank of South Central Michigan":@0,
                                         @"Feeding America West Michigan Food Bank":@0,
                                         @"Gleaners Community Food Bank of Southeastern Michigan":@0,
                                         @"Food Bank of Eastern Michigan":@0,
                                         @"Greater Lansing Food Bank":@0,
                                         @"Forgotten Harvest":@0},
                           @"Minnesota":@{@"North Country Food Bank":@0,
                                          @"Second Harvest Northern Lakes Food Bank":@0,
                                          @"Second Harvest North Central Food Bank":@0,
                                          @"Channel One Food Bank":@0,
                                          @"Second Harvest Heartland":@100},
                           @"Missouri":@{@"St. Louis Area Foodbank":@0,
                                         @"The Food Bank for Central & Northeast Missouri":@0,
                                         @"Harvesters - The Community Food Network":@0,
                                         @"Southeast Missouri Food Bank":@0,
                                         @"Ozarks Food Bank":@200,
                                         @"Second Harvest Community Food Bank":@0},
                           @"Mississippi":@{@"Mississippi Food Network":@0},
                           @"Montana":@{@"Montana Food Bank Network":@0},
                           @"North Carolina":@{@"Food bank of Albemarie":@0,
                                               @"Second Harvest Food Bank of Southeast North Carolina":@0,
                                               @"Food Bank of Central & Eastern North Carolina":@0,
                                               @"Inter-Faith Food Shuttle":@0,
                                               @"Second Harvest Food Bank of Northwest North Carolina":@0},
                           @"North Dakota":@{@"Great Plains Food Bank":@0},
                           @"Nebraska":@{@"Food Bank of Lincoln":@0,
                                         @"Food Bank for the Heartland":@0},
                           @"New Hampshire":@{@"New Hampshire Food Bank":@0},
                           @"New Jersey":@{@"Community FoodBank of New Jersey":@0,
                                           @"The FoodBank of Monmouth and Ocean Counties":@0,
                                           @"Food Bank of South Jersey":@0},
                           @"New Mexico":@{@"Roadrunner Food Bank":@0},
                           @"Nevada":@{@"Three Square Food Bank":@0,
                                       @"Food Bank of Northern Nevada":@0},
                           @"New York":@{@"Island Harvest":@0,
                                         @"Food Bank of Western New York":@0,
                                         @"Food Bank of Southern Tier":@0,
                                         @"Food Bank for Westchester":@0,
                                         @"Long Island Care":@40,
                                         @"Regional Food Bank of Northeastern NY":@0,
                                         @"Food Bank for New York City":@0,
                                         @"City Harvest":@0,
                                         @"Foodlink":@0,
                                         @"Food Bank of Central New York":@0},
                           @"Ohio":@{@"Akron-Canton Regional Foodbank":@0,
                                     @"Freestore Foodbank":@0,
                                     @"Greater Cleveland Food Bank":@0,
                                     @"The Foodbank":@0,
                                     @"Shared Harvest Foodbank":@0,
                                     @"Mid-Ohio Foodbank":@50,
                                     @"West Ohio Food Bank":@0,
                                     @"SE Ohio Foodbank":@0,
                                     @"Second Harvest Food Bank of North Central Ohio":@0,
                                     @"Second Harvest Foodbank of Clar, Champaign, & Logan Counties":@0,
                                     @"Toledo Northwestern Ohio Food Bank":@0,
                                     @"Second Harvest Food Bank of the Mahoning Valley":@0,
                                         @"Community Food Share":@0},
                           @"Oklahoma":@{@"Regional Food Bank of Oklahoma":@0,
                                         @"Community Food Bank of Eastern Oklahoma":@0},
                           @"Oregon":@{@"Oregon Food Bank":@0},
                           @"Pennsylvania":@{@"Westmoreland County Food Bank":@0,
                                             @"Greater Pittsburgh Community Food Bank":@0,
                                             @"Second Harvest Food Bank of Northwest Pennsylvania":@0,
                                             @"Central Pennsylvania Food Bank":@0,
                                             @"Second Harvest Food Bank of Lehigh Valley and NE Pennsylvania":@0,
                                             @"Philabundance":@0,
                                             @"H & J Weinberg NE PA Regional Food Bank":@0,
                                             @"Greater Berks Food Bank":@0,
                                             @"Community Food Warehouse of Mercer County":@0},
                           @"Puerto Rico":@{@"Banco de Alimentos de Puerto Rico":@0},
                           @"Rhode Island":@{@"Rhode Island Community Food Bank":@0},
                           @"South Carolina":@{@"Lowcountry Food Bank":@0,
                                               @"Harvest Hope Food Bank":@0},
                           @"South Dakota":@{@"Feeding South Dakota":@0},
                           @"Tennessee":@{@"Chattanooga Area Food Bank":@0,
                                          @"Second Harvest Food Bank of Northeast Tennessee":@0,
                                          @"Second Harvest Food Bank of East Tennessee":@0,
                                          @"Mid-South Food Bank":@0,
                                          @"Second Harvest Food Bank of Middle Tennessee":@0},
                           @"Texas":@{@"Food Bank of West Central Texas":@0,
                                      @"High Plains Food Bank":@0,
                                      @"Central Texas Food Bank":@0,
                                      @"Southeast Texas Food Bank":@0,
                                      @"Food Bank of Corpus Christi":@0,
                                      @"North Texas Food Bank":@0,
                                      @"El Pasoans Fighting Hunger":@0,
                                      @"Tarrant Area Food Bank":@0,
                                      @"Houston Food Bank":@0,
                                      @"South Texas Food Bank":@0,
                                      @"South Plains Food Bank":@0,
                                      @"West Texas Food Bank":@0,
                                      @"Food Bank of the Rio Grande Valley":@0,
                                      @"San Antonio Food Bank":@0,
                                      @"East Texas Food Bank":@0,
                                      @"Food Bank of the Golden Crescent":@0,
                                      @"Wichita Falls Area Food Bank":@0},
                           @"Utah":@{@"Utah Food Bank":@0},
                           @"Virginia":@{@"Fredericksburg Regional Foodbank":@0,
                                         @"Virginia Peninsula Foodbank":@0,
                                         @"Foodbank of Southeastern Virginia":@0,
                                         @"FeedMore":@0,
                                         @"Feeding America Southwest Virginia":@0,
                                         @"Blue Ridge Area Food Bank":@0},
                           @"Vermont":@{@"Vermont Foodbank":@0},
                           @"Washington":@{@"Food Lifeline":@0,
                                           @"Second Harvest Inland Northwest":@0},
                           @"Wisconsin":@{@"Second Harvest Foodbank of Southern Wisconsin":@0,
                                          @"Feeding America Eastern Wisconsin":@0},
                           @"West Virginia":@{@"Mountaineer Food Bank":@0,
                                              @"Facing Hunger Foodbank":@0}};


        getDict = [[NSMutableDictionary alloc] init];

    self.foodBankSectionTitles = [[foodBanks allKeys]sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

        [[NSUserDefaults standardUserDefaults] setObject:foodBankSectionTitles forKey:@"titles"];
        [[NSUserDefaults standardUserDefaults] synchronize];
      
        NSIndexPath *myIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:myIndexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
        //[self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
        [self getTotalAmount];
        [self findLargestAmount];
    }

    -(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
        
    
        if(searchText.length == 0)
        {
            isFiltered = NO;
        }
        else
        {
        isFiltered = YES;
        
            if (filteredTableData == nil)
                filteredTableData = [[NSMutableArray alloc] init];
            else
                [filteredTableData removeAllObjects];
        
            for (NSString* string in self.foodBankSectionTitles)
            {
                NSRange nameRange = [string rangeOfString:searchBar.text options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch)];
                if(nameRange.location != NSNotFound)
                {
                    
                    [filteredTableData addObject:string];
                } else {
                    NSLog(@"not found");
                    
                }
            }
        }

        [self.tableView reloadData];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        
    }

    -(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
    {
        [filteredTableData removeAllObjects];
        [filteredTableData addObjectsFromArray:self.foodBankSectionTitles];
        [self.tableView reloadData];
    }


    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        // Return the number of sections.
        if(!isFiltered) {
            return [foodBankSectionTitles count];
        } else {
            
            return [filteredTableData count];
        }
    }
    
    //Title at each section
    - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
    {
        if(!isFiltered) {
            return [foodBankSectionTitles objectAtIndex:section];
        } else {
            return [filteredTableData objectAtIndex:section];
        }
    }

    //Number of rows
    - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        // Return the number of rows in the section.
       if(!isFiltered) {
            NSString *sectionTitle = [foodBankSectionTitles objectAtIndex:section];
            NSArray *sectionModels = [foodBanks objectForKey:sectionTitle];
            return [sectionModels count];
        } else {
            NSString *sectionTitles = [filteredTableData objectAtIndex:section];
            NSArray *sectionModels2 = [foodBanks objectForKey:sectionTitles];
           // NSLog(@"sectionModels2 %@",sectionModels2);
            return [sectionModels2 count];
        }
    }
    
    //Item at each cell
    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moneyCell" forIndexPath:indexPath];
    
        if(!isFiltered) {// Configure the cell...
            NSString *sectionTitle = [foodBankSectionTitles objectAtIndex:indexPath.section];
            NSDictionary *Street=[self.foodBanks objectForKey:sectionTitle];// objectForKey:@"Food Bank of North Alabama"];
            NSArray *keys = [Street allKeys];
            NSString *model = [keys objectAtIndex:indexPath.row];
            NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:model];
            NSString *raised=[[self.foodBanks objectForKey:sectionTitle] objectForKey:model];
            NSInteger added = [raised integerValue] + value;
            raised = [NSString stringWithFormat:@"%d",added];
            cell.nameLabel.text = model;
            cell.raisedLabel.text = @"Raised: $";
            cell.raisedAmountLabel.text =[NSString stringWithFormat:@"%@",raised];
       
            [getDict setObject:raised forKey:model];
        
        } else {
            NSString *sectionTitles = [filteredTableData objectAtIndex:indexPath.section];
            NSDictionary *Street2=[self.foodBanks objectForKey:sectionTitles];// objectForKey:@"Food Bank of North Alabama"];
            NSArray *keys2 = [Street2 allKeys];
            NSString *model2 = [keys2 objectAtIndex:indexPath.row];
            NSInteger value2 = [[NSUserDefaults standardUserDefaults] integerForKey:model2];
            NSString *raised2=[[self.foodBanks objectForKey:sectionTitles] objectForKey:model2];
            NSInteger added2 = [raised2 integerValue] + value2;
            raised2 = [NSString stringWithFormat:@"%d",added2];
            cell.nameLabel.text = model2;
            cell.raisedLabel.text = @"Raised: $";
            cell.raisedAmountLabel.text =[NSString stringWithFormat:@"%@",raised2];
           // cell.raisedAmountLabel.text =[NSString stringWithFormat:@"%@",raised2];

            //cell.nameLabel.text = [sectionModels2 objectAtIndex:indexPath.row];
            //NSLog(@"filtered rows %@", [sectionModels2 objectAtIndex:indexPath.row]);
            //cell.raisedLabel.text = @"Raised: $";
            //cell.raisedAmountLabel.text =[NSString stringWithFormat:@"%@",raised];
        }

        return cell;
    }

// want to call this from View Controller
-(void)getTotalAmount {
  

    NSMutableDictionary *getdata=[[NSMutableDictionary alloc]init];
    for(id str in foodBankSectionTitles) {
        [getdata addEntriesFromDictionary:[foodBanks objectForKey:str]];
    }
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    NSString *var;
    for(id str1 in getdata) {
        var = [getdata objectForKey:str1];
        [arr addObject:var];
    }
    NSInteger num = 0;
    NSInteger total = 0;
    for(id str2 in arr) {
        num = [str2 integerValue];
        total = total + num;
    }
    NSString *var2;
    for(id str3 in getdata) {
        var2 = [getdata objectForKey:str3];
    }
    if(total<10000) {
        _totalAmount = [NSString stringWithFormat:@"%d", total];
        NSInteger index = [_totalAmount integerValue];
        [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"integer"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



-(void)findLargestAmount {
    
    NSMutableDictionary *getdata=[[NSMutableDictionary alloc]init];
    for(id str in foodBankSectionTitles) {
        [getdata addEntriesFromDictionary:[foodBanks objectForKey:str]];
    }
    NSString *var;
    NSInteger amount;
    NSInteger max1 = 0;
    NSString *maxBank1;
    NSInteger max2 = 0;
    NSString *maxBank2;
    NSInteger max3 = 0;
    NSString *maxBank3;
    NSInteger max4 = 0;
    NSString *maxBank4;

    for(id str1 in getdata) {
        var = [getdata objectForKey:str1];
        amount = [var integerValue];
        
        if([[NSUserDefaults standardUserDefaults] objectForKey:str1] != nil) {
            NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:str1];
            amount = amount + value;
        }
        
        if(amount > max1) {
            max4 = max3;
            max3 = max2;
            max2 = max1;
            maxBank1 = str1;
            max1 = amount;
        } else if (amount > max2) {
            max4 = max3;
            max3 = max2;
            maxBank2 = str1;
            max2 = amount;
        } else if (amount > max3) {
            max4 = max3;
            maxBank3 = str1;
            max3 = amount;
        } else if (amount > max4) {
            maxBank4 = str1;
            max4 = amount;
           
        }

    }
    
    [[NSUserDefaults standardUserDefaults] setInteger:max1 forKey:@"max1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setInteger:max2 forKey:@"max2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setInteger:max3 forKey:@"max3"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:maxBank1 forKey:@"maxBank1"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:maxBank2 forKey:@"maxBank2"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setObject:maxBank3 forKey:@"maxBank3"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *sectionTitle = [foodBankSectionTitles objectAtIndex:indexPath.section];
    NSDictionary *Street=[self.foodBanks objectForKey:sectionTitle];
    NSArray *keys = [Street allKeys];
    NSString *model = [keys objectAtIndex:indexPath.row];
    self.foodLabel = model;
    NSString *moneyStr = [getDict valueForKey:model];
    [[NSUserDefaults standardUserDefaults]setObject:moneyStr forKey:@"moneyStr"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self performSegueWithIdentifier:@"detail" sender:self.foodLabel];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     DetailViewController *detailVC = (DetailViewController *)[[segue destinationViewController] topViewController];
    detailVC.foodBankString = sender;
    
}

    @end
