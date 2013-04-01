//
//  RaceDetailViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 3/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "RaceDetailViewController.h"
#import "RaceReviewsViewController.h"


@interface RaceDetailViewController ()

@end

@implementation RaceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    race_name_lable.text = [appDelegate.app_del_current_race_dictionary objectForKey:@"race_name"];
    
    race_details_lable.text = [appDelegate.app_del_current_race_dictionary objectForKey:@"race_info"];
    
    
    race_number_of_questions_lable.text = [appDelegate.app_del_current_race_dictionary objectForKey:@"number_of_questions"];
    
    race_completed_lable.text = [appDelegate.app_del_current_race_dictionary objectForKey:@"number_of_completion"];
    
    race_rating_lable.text = [appDelegate.app_del_current_race_dictionary objectForKey:@"race_rating"];
    
    race_number_of_revies_lable.text = [appDelegate.app_del_current_race_dictionary objectForKey:@"number_of_reviewes"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma  mark - read_reviews_clicked

-(IBAction)read_reviews_clicked:(id)sender
{
    NSLog(@"\n read_reviews_clicked");
    RaceReviewsViewController *viewController = [[RaceReviewsViewController alloc] initWithNibName:@"RaceReviewsViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:TRUE];
    [viewController release];
    
    
}

#pragma  mark - start_game_clicked

-(IBAction)start_game_clicked:(id)sender
{
    NSLog(@"\n start_game_clicked");
}



@end
