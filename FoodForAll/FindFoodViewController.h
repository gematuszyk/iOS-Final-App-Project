//
//  FindFoodViewController.h
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface FindFoodViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic,retain) UIView *actionOverlayCalloutView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;



@end
