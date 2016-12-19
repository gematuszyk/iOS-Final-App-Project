//
//  InfoWindow.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 12/6/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "InfoWindow.h"

@implementation InfoWindow


- (instancetype)init {
    
    if(self = [super init]){
        // Creating the large movie image

        
        // Creating the tag Label

        
        // Creating the plot label
        _plotLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 299, 355, 200)];
        self.plotLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        

        [self addSubview:self.plotLabel];
    }
    
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
