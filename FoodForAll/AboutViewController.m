//
//  AboutViewController.m
//  FoodForAll
//
//  Created by Grace Matuszyk on 11/2/16.
//  Copyright © 2016 nyu.edu. All rights reserved.
//

#import "AboutViewController.h"

#import "SWRevealViewController.h"

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    UIView *box  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 248)];
    box.backgroundColor = [[UIColor alloc]initWithRed:211/255.0 green:210/255.0 blue:212/255.0 alpha:1];
    [self.view insertSubview:box atIndex:0];
   
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Agencies", @"Our Mission", @"History", nil]];
    [segmentedControl sizeToFit];
    segmentedControl.selectedSegmentIndex = 1;
    [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents: UIControlEventValueChanged];
    self.navigationItem.titleView = segmentedControl;
    segmentedControl.tintColor = [UIColor whiteColor];
    self.imageView.image = [UIImage imageNamed:@"donating.jpg"];
    self.titleLabel.text = @"Our Mission";
    self.textView.text = @"The Feeding America network is the nation’s largest domestic hunger-relief organization. Together with individuals, charities, businesses and government we can end hunger. In a country that wastes billions of pounds of food each year, it's almost shocking that anyone in America goes hungry. Yet every day, there are millions of children and adults who do not get the meals they need to thrive. We work to get nourishing food – from the farmers, manufacturers, and retailers – to people in need. At the same time, we also seek to help the people we serve build a path to a brighter, food-secure future.";

    _imageView.alpha = 0.9;
}


- (void)segmentAction:(UISegmentedControl *)segment
{

    switch (segment.selectedSegmentIndex) {
        case 0:

            self.titleLabel.text = @"Agencies";
            self.imageView.image = [UIImage imageNamed:@"donating2.jpg"];
            self.textView.text = @"The Regional Food Bank provides food assistance to over 1,000 charitable agencies serving hungry and disadvantaged people, including:\n\n- Food Pantries\n- Soup Kitchens\n- Emergency Shelters\n- Youth Programs\n- Senior Programs\n- Programs for the Disabled\n\nThese agencies receive more than half of their food from the Regional Food Bank and report that loss of support from the Food Bank would have a devastating or significant impact on their operations (Hunger in America 2006).\n\nPeople of all ages, races, genders, and physical and mental abilities benefit from the work of the Food Bank. Nearly 50% of the people served by food pantries are children.\n\nThe Food Bank supports and operates a range of programs to maximize the amount of food and technical support it provides:";
            break;
        case 1:

            self.titleLabel.text = @"Our Mission";
            self.imageView.image = [UIImage imageNamed:@"donating.jpg"];
            self.textView.text = @"The Feeding America network is the nation’s largest domestic hunger-relief organization. Together with individuals, charities, businesses and government we can end hunger. In a country that wastes billions of pounds of food each year, it's almost shocking that anyone in America goes hungry. Yet every day, there are millions of children and adults who do not get the meals they need to thrive. We work to get nourishing food – from the farmers, manufacturers, and retailers – to people in need. At the same time, we also seek to help the people we serve build a path to a brighter, food-secure future.";
            break;
        case 2:

            self.titleLabel.text = @"History";
            self.imageView.image = [UIImage imageNamed:@"donating3.jpg"];
            self.textView.text = @"For 35 years, Feeding America has responded to the hunger crisis in America by providing food to people in need through a nationwide network of food banks.\n\nThe concept of food banking was developed by John van Hengel in Phoenix, AZ in the late 1960s. Van Hengel, a retired businessman, had been volunteering at a soup kitchen trying to find food to serve the hungry. One day, he met a desperate mother who regularly rummaged through grocery store garbage bins to find food for her children. She suggested that there should be a place where, instead of being thrown out, discarded food could be stored for people to pick up—similar to the way “banks” store money for future use. With that, an industry was born.\n\nAs the number of food banks began to increase, van Hengel created a national organization for food banks and in 1979 he established Second Harvest, which was later called America’s Second Harvest the Nation’s Food Bank Network. In 2008, the network changed its name to Feeding America to better reflect the mission of the organization.\n\nToday, Feeding America is the nation’s largest domestic hunger-relief organization—a powerful and efficient network of 200 food banks across the country. As food insecurity rates hold steady at the highest levels ever, the Feeding America network of food banks has risen to meet the need. We feed 46 million people at risk of hunger, including 12 million children and 7 million seniors. Support Feeding America and help solve hunger. Donate. Volunteer. Advocate. Educate.";
            break;
        default:
            break;
    }
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
