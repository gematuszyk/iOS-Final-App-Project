//
//  AboutViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;


@property (strong, nonatomic) UIView *myBox1;
@property (strong, nonatomic) UIView *myBox2;
@property (strong, nonatomic) UIView *myBox3;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;


@end
