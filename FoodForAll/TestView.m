//
//  TestView.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/17/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "TestView.h"
#import "DetailViewController.h"

@interface TestView () {
    CGFloat startAngle;
    CGFloat endAngle;
    NSDictionary *dict;
}

@end

@implementation TestView


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
    NSString *money;
    NSInteger savedIndex;
    savedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"integer"];

    NSInteger value = [[NSUserDefaults standardUserDefaults] integerForKey:@"final"];
    savedIndex = savedIndex + value;
    money = [NSString stringWithFormat:@"%d",savedIndex];
    

    //get total values from donate money table
    NSInteger percentIndex = savedIndex;
    [[NSUserDefaults standardUserDefaults] setInteger:percentIndex forKey:@"percentIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // Display our percentage as a string
    NSNumber *myDoubleNumber = [NSNumber numberWithDouble:self.percent];
    NSString *str = [myDoubleNumber stringValue];
    
    NSString* textContent = [NSString  stringWithFormat:@" %.@%%", str];
    NSString* textContent1 = [NSString  stringWithFormat:@"$%@", money];
    
   

    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    // Create our arc, with the correct angles
    [bezierPath addArcWithCenter:CGPointMake(rect.size.width / 2, (rect.size.height / 2)-29)
                          radius:115
                      startAngle:startAngle
                        endAngle:(endAngle - startAngle) * (_percent / 100.0) + startAngle
                       clockwise:YES];
    
    CGSize translation = CGSizeMake(0, -25);
    [bezierPath applyTransform:CGAffineTransformMakeTranslation(translation.width,
                                                                translation.height)];
    // Set the display for the path, and stroke it
    bezierPath.lineWidth = 30;
    [[UIColor colorWithRed:(125/255.0)  green:(188/255.0)  blue:(184/255.0)  alpha:0.8] setStroke];
    [bezierPath stroke];

    
    
    // Text Drawing
    CGRect textRect = CGRectMake((rect.size.width / 2.0) - 124/2.0, (rect.size.height / 2.0) -230/2.0, 125, 100);
    [[UIColor blackColor] setFill];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 51.5],
                                  NSParagraphStyleAttributeName : paragraphStyle,
                                  NSForegroundColorAttributeName : [UIColor whiteColor]};
        [textContent drawInRect: textRect withAttributes: attributes];

    
    CGRect textRect1 = CGRectMake((rect.size.width / 2.0) - 124/2.0, (rect.size.height / 2.0) -120/2.0, 125, 100);
    [[UIColor blackColor] setFill];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle1.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes1 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 38.5],
                                  NSParagraphStyleAttributeName : paragraphStyle1,
                                  NSForegroundColorAttributeName : [UIColor whiteColor]};
    [textContent1 drawInRect: textRect1 withAttributes: attributes1];

    
    
    NSString* textContent2 = [NSString  stringWithFormat:@"Total amount of money\n donated to all Food Banks"];
    CGRect textRect2 = CGRectMake(-40, 20, 400, 100);
    NSMutableParagraphStyle * paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle2.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle2.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes2 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 22.5],
                                  NSParagraphStyleAttributeName : paragraphStyle2,
                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                   };
    [textContent2 drawInRect: textRect2 withAttributes: attributes2];
    
    [donateController viewDidLoad];
    [donateController viewWillAppear:YES];
    [donateController findLargestAmount];
    
    NSString *maxBank1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"maxBank1"];
    NSString* textContent3 = maxBank1;
    CGRect textRect3 = CGRectMake(60, 470, 200, 100);
    NSMutableParagraphStyle * paragraphStyle3 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle3.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle3.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes3 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 13],
                                   NSParagraphStyleAttributeName : paragraphStyle3,
                                   NSForegroundColorAttributeName : [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0]
                                   };
    [textContent3 drawInRect: textRect3 withAttributes: attributes3];
    
    NSString *maxBank2 = [[NSUserDefaults standardUserDefaults] objectForKey:@"maxBank2"];
    NSString* textContent6 = maxBank2;
    CGRect textRect6 = CGRectMake(5, 530, 120, 200);
    NSMutableParagraphStyle * paragraphStyle6 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle6.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle6.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes6 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 13],
                                   NSParagraphStyleAttributeName : paragraphStyle6,
                                   NSForegroundColorAttributeName : [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0]
                                   };
    [textContent6 drawInRect: textRect6 withAttributes: attributes6];
    
    NSString *maxBank3 = [[NSUserDefaults standardUserDefaults] objectForKey:@"maxBank3"];
    NSString* textContent7 = maxBank3;
    CGRect textRect7 = CGRectMake(185, 530, 135, 200);
    NSMutableParagraphStyle * paragraphStyle7 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle7.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle7.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes7 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 13],
                                   NSParagraphStyleAttributeName : paragraphStyle7,
                                   NSForegroundColorAttributeName : [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0]
                                   };
    [textContent7 drawInRect: textRect7 withAttributes: attributes7];
    
    NSString* textContent8 = [NSString  stringWithFormat:@"Donation Statistics"];
    CGRect textRect8 = CGRectMake(10, 430, 400, 100);
    NSMutableParagraphStyle * paragraphStyle8 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle8.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle8.alignment = NSTextAlignmentLeft;
    
    NSDictionary *attributes8 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica-Bold" size: 18.5],
                                   NSParagraphStyleAttributeName : paragraphStyle8,
                                   NSForegroundColorAttributeName : [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0]
                                   };
    [textContent8 drawInRect: textRect8 withAttributes: attributes8];

    

    NSString* textContent5 = [NSString  stringWithFormat:@"Goal: $10,000"];
    CGRect textRect5 = CGRectMake(-40, 380, 400, 100);
    NSMutableParagraphStyle * paragraphStyle5 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle5.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle5.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes5 = @{ NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 24.5],
                                   NSParagraphStyleAttributeName : paragraphStyle5,
                                   NSForegroundColorAttributeName : [UIColor whiteColor]
                                   };
    [textContent5 drawInRect: textRect5 withAttributes: attributes5];
    
    
    
    
}







@end
