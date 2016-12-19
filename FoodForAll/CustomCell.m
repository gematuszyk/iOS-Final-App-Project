//
//  CustomCell.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/22/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize nameLabel = _nameLabel;
@synthesize raisedLabel = _raisedLabel;
@synthesize raisedAmountLabel = _raisedAmountLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
