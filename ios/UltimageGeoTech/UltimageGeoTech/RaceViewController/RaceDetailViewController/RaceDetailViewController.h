//
//  RaceDetailViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 3/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface RaceDetailViewController : UIViewController
{
    IBOutlet UILabel*race_name_lable;
    IBOutlet UILabel*race_details_lable;
    IBOutlet UILabel*race_number_of_questions_lable;
    IBOutlet UILabel*race_completed_lable;
    IBOutlet UILabel*race_rating_lable;
    IBOutlet UILabel*race_number_of_revies_lable;
    
    AppDelegate*appDelegate;
    
}

-(IBAction)read_reviews_clicked:(id)sender;
-(IBAction)start_game_clicked:(id)sender;


@end
