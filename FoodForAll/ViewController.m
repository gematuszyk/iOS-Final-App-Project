//
//  ViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "ViewController.h"
#import "DonateTableViewController.h"
#import "SWRevealViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DonateTableViewController *donateController = [[DonateTableViewController alloc] init];
    [donateController viewDidLoad];
    [donateController viewWillAppear:YES];
    [donateController findLargestAmount];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image.png"]];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButton setTarget: self.revealViewController];
        [self.barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }self.revealViewController.rearViewRevealWidth = 100;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:19.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    label.text = NSLocalizedString(@"FoodForAll", @"");
    [label sizeToFit];

    //  custom hamburger nav bar button
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    btnNext1.frame = CGRectMake(90, 100, 30, 30);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    // encompassing circle
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(([[UIScreen mainScreen] bounds].size.width -280)/2, 90, 280, 280)] CGPath]];
    [circleLayer setFillColor:[[[UIColor alloc]initWithRed:39/255.0 green:60/255.0 blue:80/255.0 alpha:1.0]CGColor]];
    [_scroll.layer setMasksToBounds:YES];
    
    // white inner circle
    CAShapeLayer *circleLayer5 = [CAShapeLayer layer];
    [circleLayer5 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(([[UIScreen mainScreen] bounds].size.width -260)/2, 100, 260, 260)] CGPath]];
    [circleLayer5 setFillColor:[[[UIColor alloc]initWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0]CGColor]];
    [_scroll.layer setMasksToBounds:YES];

    // center circle
    CAShapeLayer *circleLayer2 = [CAShapeLayer layer];
    [circleLayer2 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(([[UIScreen mainScreen] bounds].size.width -200)/2, 130, 200, 200)] CGPath]];
    [circleLayer2 setFillColor:[[[UIColor alloc]initWithRed:39/255.0 green:60/255.0 blue:80/255.0 alpha:1.0]CGColor]];
    [_scroll.layer setMasksToBounds:YES];
    
    // encompassing circle for stats box
    CAShapeLayer *circleLayer3 = [CAShapeLayer layer];
    [circleLayer3 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(([[UIScreen mainScreen] bounds].size.width -160)/2, 555, 160, 160)] CGPath]];
    [circleLayer3 setFillColor:[[[UIColor alloc]initWithRed:39/255.0 green:60/255.0 blue:80/255.0 alpha:1.0]CGColor]];
    [_scroll.layer setMasksToBounds:YES];
    
    // inner circle circle for stats box
    CAShapeLayer *circleLayer7 = [CAShapeLayer layer];
    [circleLayer7 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(([[UIScreen mainScreen] bounds].size.width -138)/2, 567, 138, 138)] CGPath]];
    [circleLayer7 setFillColor:[[UIColor whiteColor]CGColor]];
    [_scroll.layer setMasksToBounds:YES];
    
    // center circle for stats box
    CAShapeLayer *circleLayer4 = [CAShapeLayer layer];
    [circleLayer4 setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake(([[UIScreen mainScreen] bounds].size.width -110)/2, 581, 110, 110)] CGPath]];
    [circleLayer4 setFillColor:[[[UIColor alloc]initWithRed:39/255.0 green:60/255.0 blue:80/255.0 alpha:1.0]CGColor]];
    [_scroll.layer setMasksToBounds:YES];

    
    m_testView = [[TestView alloc] initWithFrame:self.view.bounds];
    m_testView.percent = 0;
    m_testView.userInteractionEnabled = NO;
     [_scroll insertSubview:m_testView atIndex:3];
    
    m_testView2 = [[TestView2 alloc] initWithFrame:self.view.bounds];
    m_testView2.percent = 0;
    m_testView2.userInteractionEnabled = NO;
    [_scroll insertSubview:m_testView2 atIndex:2];
    
    
    NSInteger max = [[NSUserDefaults standardUserDefaults] integerForKey:@"max1"];
    [[NSUserDefaults standardUserDefaults] setInteger:max forKey:@"max"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIView *myBox2  = [[UIView alloc] initWithFrame:CGRectMake(0, 437, [[UIScreen mainScreen] bounds].size.width, 295)];
    myBox2.backgroundColor = [[UIColor alloc]initWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    [_scroll insertSubview:myBox2 atIndex:1];
    
    UIView *myBox  = [[UIView alloc] initWithFrame:CGRectMake(0, 425, [[UIScreen mainScreen] bounds].size.width, 35)];
    myBox.backgroundColor = [UIColor whiteColor];
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:myBox.bounds];
    myBox.layer.masksToBounds = NO;
    myBox.layer.shadowColor = [UIColor blackColor].CGColor;
    myBox.layer.shadowOffset = CGSizeMake(5.0f, 0.0f);
    myBox.layer.shadowOpacity = 0.5f;
    myBox.layer.shadowPath = shadowPath.CGPath;
    [_scroll insertSubview:myBox atIndex:2];
    

    [_scroll.layer insertSublayer:circleLayer below:m_testView.layer];
    [_scroll.layer insertSublayer:circleLayer5 below:m_testView.layer];
    [_scroll.layer insertSublayer:circleLayer2 below:m_testView.layer];
    [_scroll.layer insertSublayer:circleLayer3  below:m_testView2.layer];
    [_scroll.layer insertSublayer:circleLayer7  below:m_testView2.layer];
    [_scroll.layer insertSublayer:circleLayer4  below:m_testView2.layer];

    _btn1.layer.cornerRadius = 2;
    _btn1.layer.borderWidth = 1;
    _btn1.layer.borderColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0].CGColor;
    _btn2.layer.cornerRadius = 2;
    _btn2.layer.borderWidth = 1;
    _btn2.layer.borderColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0].CGColor;
    _btn3.layer.cornerRadius = 2;
    _btn3.layer.borderWidth = 1;
    _btn3.layer.borderColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0].CGColor;
    
    CGRect newFrame = m_testView2.frame;
    newFrame.size.width = 320;
    newFrame.size.height = 720;
    [m_testView2 setFrame:newFrame];
    
}
- (IBAction)buttonClicked:(UIButton *)button {
    CGRect newFrame = m_testView2.frame;
    newFrame.size.width = 320;
    newFrame.size.height = 720;
    [m_testView2 setFrame:newFrame];
    
    TestView2 *test = [[TestView2 alloc] init];
    NSInteger max;
    NSString *maxName;
    if(button.tag ==1) {
        _btn2.backgroundColor = [UIColor clearColor];
        _btn3.backgroundColor = [UIColor clearColor];
        _btn1.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
        [_btn3 setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        max = [[NSUserDefaults standardUserDefaults] integerForKey:@"max1"];
        maxName = [[NSUserDefaults standardUserDefaults] objectForKey:@"maxBank1"];
        [m_testView2 removeFromSuperview];
        m_testView2 = [[TestView2 alloc] initWithFrame:self.view.bounds];
        CGRect newFrame = m_testView2.frame;
        newFrame.size.width = 320;
        newFrame.size.height = 720;
        [m_testView2 setFrame:newFrame];
        m_testView2.percent = 0;
        m_testView2.userInteractionEnabled = NO;
        m_timer2 = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementSpin2) userInfo:nil repeats:YES];
        [_scroll addSubview:m_testView2];
        [test setNeedsDisplay];
    } else if(button.tag ==2) {
        _btn3.backgroundColor = [UIColor clearColor];
        _btn1.backgroundColor = [UIColor clearColor];
        _btn2.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
        [_btn3 setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        max = [[NSUserDefaults standardUserDefaults] integerForKey:@"max2"];
        maxName = [[NSUserDefaults standardUserDefaults] objectForKey:@"maxBank2"];
        [m_testView2 removeFromSuperview];
        m_testView2 = [[TestView2 alloc] initWithFrame:self.view.bounds];
        CGRect newFrame = m_testView2.frame;
        newFrame.size.width = 320;
        newFrame.size.height = 720;
        [m_testView2 setFrame:newFrame];
        m_testView2.percent = 0;
        m_testView2.userInteractionEnabled = NO;
        [_scroll addSubview:m_testView2];
        m_timer2 = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementSpin2) userInfo:nil repeats:YES];
        [test setNeedsDisplay];
    } else if(button.tag ==3) {
        _btn2.backgroundColor = [UIColor clearColor];
        _btn1.backgroundColor = [UIColor clearColor];
        _btn3.backgroundColor = [UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0];
        [_btn2 setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn1 setTitleColor:[UIColor colorWithRed:31/255.0 green:47/255.0 blue:62/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        max = [[NSUserDefaults standardUserDefaults] integerForKey:@"max3"];
        maxName = [[NSUserDefaults standardUserDefaults] objectForKey:@"maxBank3"];
        [m_testView2 removeFromSuperview];
        m_testView2 = [[TestView2 alloc] initWithFrame:self.view.bounds];
        CGRect newFrame = m_testView2.frame;
        newFrame.size.width = 320;
        newFrame.size.height = 720;
        [m_testView2 setFrame:newFrame];
        m_testView2.percent = 0;
        m_testView2.userInteractionEnabled = NO;
        m_timer2 = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementSpin2) userInfo:nil repeats:YES];
        [_scroll addSubview:m_testView2];
        [test setNeedsDisplay];
    }
    [[NSUserDefaults standardUserDefaults] setInteger:max forKey:@"max"];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(NSInteger) getButton {
    NSInteger buttonNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"max"];
    return buttonNum;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    // Kick off a timer to count it down
    m_timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementSpin) userInfo:nil repeats:YES];
    m_timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(incrementSpin2) userInfo:nil repeats:YES];
}

- (void)incrementSpin
{
    int result;

        NSInteger percent = [[NSUserDefaults standardUserDefaults] integerForKey:@"percentIndex"];
        NSInteger max = 10000;
        float round = (10.0f * percent / max)*10;
        result = (int)roundf(round);
    

    
    // If we can decrement our percentage, do so, and redraw the view
    if (m_testView.percent > -1 && m_testView.percent != result) {
        m_testView.percent = m_testView.percent + 1;
        [m_testView setNeedsDisplay];

    }
    else {
        [m_timer invalidate];
        m_timer = nil;
    }
}

- (void)incrementSpin2
{
    // 2nd percentage circle
    int result2;
    
    NSInteger newMax = [[NSUserDefaults standardUserDefaults] integerForKey:@"max"];
    NSInteger max4 = 10000;
    float round2 = (10.0f * newMax / max4)*10;
    result2 = (int)roundf(round2);
    [[NSUserDefaults standardUserDefaults] setInteger:result2 forKey:@"percentMax"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (m_testView2.percent > -1 && m_testView2.percent != result2) {
        m_testView2.percent = m_testView2.percent + 1;
        [m_testView2 setNeedsDisplay];
        
    }
    else {
        [m_timer2 invalidate];
        m_timer2 = nil;
    }

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
