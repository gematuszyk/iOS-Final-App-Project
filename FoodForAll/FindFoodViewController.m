//
//  FindFoodViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//
//@import GooglePlaces;
#import "FindFoodViewController.h"
#import "SWRevealViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SMCalloutView.h"
#import "SVWebViewController.h"

@interface FindFoodViewController() <GMSMapViewDelegate>{
    CLLocationManager *locationManager;
}


@end

@implementation FindFoodViewController {
    //GMSPlacesClient *_placesClient;
}

//@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _placesClient = [GMSPlacesClient sharedClient];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.barButton setTarget: self.revealViewController];
        [self.barButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
        
    }
    
        //  custom hamburger nav bar button
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"burger"] forState:UIControlStateNormal];
    btnNext1.frame = CGRectMake(90, 100, 30, 30);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:revealViewController action:@selector(revealToggle:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;

    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:35.431165
                                                            longitude:-97.614630
                                                                 zoom:3.5];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = mapView;
    mapView.delegate = self;
    NSDictionary *dictRoot = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"names" ofType:@"plist"]];
    NSArray *namesList = [NSArray arrayWithArray:[dictRoot objectForKey:@"name"]];
    NSArray *locationList = [NSArray arrayWithArray:[dictRoot objectForKey:@"location"]];
    NSArray *websiteList = [NSArray arrayWithArray:[dictRoot objectForKey:@"website"]];

    
    for(int i = 0; i < [namesList count]; i++)
    {
        NSString *name = [namesList objectAtIndex:i];
        NSString *location = [locationList objectAtIndex:i];
        NSString *website = [websiteList objectAtIndex:i];
        NSString *firstHalf, *secondHalf;
        NSArray *substrings = [location componentsSeparatedByString:@", "];
        firstHalf =[substrings objectAtIndex:0];
        secondHalf =[substrings objectAtIndex:1];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([firstHalf doubleValue], [secondHalf doubleValue]);
        marker.flat = YES;
        marker.title = name;
        marker.snippet = website;
        marker.icon = [UIImage imageNamed:@"pin.png"];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = mapView;
    }
    

    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate= self;
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
    [locationManager requestWhenInUseAuthorization];
    [locationManager requestAlwaysAuthorization];
    mapView.myLocationEnabled =  NO;
    mapView.settings.myLocationButton =  YES;
    

}

-(void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker{

    NSString *web = [NSString stringWithFormat:@"http://%@",marker.snippet];
    NSURL *URL = [NSURL URLWithString:web];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
   
    NSLog(@"%@",marker.snippet);
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}




//- (void)whenSearchClicked:(id)sender
//{
//    NSArray *buttonsArray = self.navigationController.navigationBar.topItem.leftBarButtonItems;
//    for(UIBarButtonItem *item in buttonsArray)
//    {
//        if(item.tag == 1 && item.customView.hidden)
//        {
//            item.customView.hidden = NO;
//            if([item.customView isKindOfClass:[UISearchBar class]])
//                [item.customView becomeFirstResponder];
//            UIBarButtonItem *rightItem = self.navigationController.navigationBar.topItem.rightBarButtonItem;//single rite item for this example
//            [rightItem setTitle:@"Cancel"];
//        }
//        else
//        {
//            item.customView.hidden = YES;
//            if([item.customView isKindOfClass:[UISearchBar class]])
//                [item.customView resignFirstResponder];
//            UIBarButtonItem *rightItem = self.navigationController.navigationBar.topItem.rightBarButtonItem;
//            [rightItem setTitle:@"Search"];
//            
//        }
//    }
//    
//}
//
//
//- (IBAction)getCurrentPlace:(UIButton *)sender {
//    [_placesClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error){
//        if (error != nil) {
//            NSLog(@"Pick Place error %@", [error localizedDescription]);
//            return;
//        }
//        
//        self.nameLabel.text = @"No current place";
//        self.addressLabel.text = @"";
//        
//        if (placeLikelihoodList != nil) {
//            GMSPlace *place = [[[placeLikelihoodList likelihoods] firstObject] place];
//            if (place != nil) {
//                self.nameLabel.text = place.name;
//                self.addressLabel.text = [[place.formattedAddress componentsSeparatedByString:@", "]
//                                          componentsJoinedByString:@"\n"];
//            }
//        }
//    }];
//}
//
//
//
//
#define kGoogleAutoCompleteAPI @"https://maps.googleapis.com/maps/api/place/autocomplete/json?key=%@&input=%@"
//



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
