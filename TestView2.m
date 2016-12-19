//
//  TestView2.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/30/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "TestView2.h"
#import "DonateTableViewController.h"
#import "ViewController.h"

@interface TestView2 () {
    CGFloat startAngle;
    CGFloat endAngle;
    NSDictionary *dict;
}

@end

@implementation TestView2


- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        UIColor *colour = [UIColor clearColor];
        self.backgroundColor = colour;
        
        // Determine our start and stop angles for the arc (in radians)
        startAngle = M_PI * 1.5;
        endAngle = startAngle + (M_PI * 2);
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    DonateTableViewController *donateController = [[DonateTableViewController alloc] init];
    [donateController viewDidLoad];
    [donateController viewWillAppear:YES];
    [donateController findLargestAmount];
    
    
    NSInteger numm = [[NSUserDefaults standardUserDefaults] integerForKey:@"percentMax"];
    NSString *str = [NSString stringWithFormat:@"%d",numm];
    NSString *money = [[NSUserDefaults standardUserDefaults] objectForKey:@"max"];
    NSString* textContent = [NSString  stringWithFormat:@" %.@%%", str];
    NSString* textContent2 = [NSString  stringWithFormat:@"$%@",money];
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    
    [bezierPath addArcWithCenter:CGPointMake([[UIScreen mainScreen] bounds].size.width/2, 661)
                          radius:62
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * (_percent / 100.0) + startAngle
                       clockwise:YES];
    CGSize translation = CGSizeMake(0, -25);
    [bezierPath applyTransform:CGAffineTransformMakeTranslation(translation.width, translation.height)];
    bezierPath.lineWidth = 14;
    [[UIColor colorWithRed:(125/255.0)  green:(188/255.0)  blue:(184/255.0)  alpha:0.8] setStroke];
    [bezierPath stroke];
    
    
    // Text Drawing
    CGRect textRect = CGRectMake(([[UIScreen mainScreen] bounds].size.width-130)/2, 608, 130, 100);
    [[UIColor blackColor] setFill];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 29.5],
                                  NSParagraphStyleAttributeName : paragraphStyle,
                                  NSForegroundColorAttributeName : [UIColor whiteColor]};
    [textContent drawInRect: textRect withAttributes: attributes];
    
    // Text Drawing
    CGRect textRect2 = CGRectMake(([[UIScreen mainScreen] bounds].size.width-130)/2, 640, 130, 100);
    [[UIColor blackColor] setFill];
    NSMutableParagraphStyle * paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle2.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle2.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes2 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 22.5],
                                  NSParagraphStyleAttributeName : paragraphStyle2,
                                  NSForegroundColorAttributeName : [UIColor whiteColor]};
    [textContent2 drawInRect: textRect2 withAttributes: attributes2];
    

}




@end
