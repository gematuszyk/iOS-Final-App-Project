//
//  NavigationTableViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavigationTableViewController : UITableViewController

@property (nonatomic, copy) NSString *sideBarButtonImageName;


- (void)addShadowToViewController:(UIViewController *)viewController;


@end


