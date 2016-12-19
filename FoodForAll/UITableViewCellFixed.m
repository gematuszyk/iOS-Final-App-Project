//
//  UITableViewCellFixed.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/15/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "UITableViewCellFixed.h"

@implementation UITableViewCellFixed
- (void) layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(0, 0, 320, 20);
}
@end
