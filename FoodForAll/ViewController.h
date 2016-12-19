//
//  ViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestView.h"
#import "TestView2.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>{
    TestView* m_testView;
    TestView2* m_testView2;
    NSTimer* m_timer;
    NSTimer* m_timer2;

}
@property (weak, nonatomic) IBOutlet UIScrollView *scroll;


@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

- (IBAction)buttonClicked:(UIButton *)button;
-(NSInteger) getButton;

@end

