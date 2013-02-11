//
//  AppDelegate.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 1/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>
{
    Facebook *facebook;
    NSUserDefaults *user_defaults;
    
    NSMutableDictionary*user_information_dictionary;//this dictionary have all the info.regarding user
    
    float current_latitude;
    float current_longitued;
    
    
    
    
    
    UIButton *btnRace;
    UIButton *btnCreateRace;
    UIButton *btnScore;
    UIButton *btnHome;
    UIButton *btnAccount;
    UIView*bottomView;
    
    
    //Race Question information..
    NSMutableArray*current_race_question_array;
    
    float current_question_latitude;
    float current_question_longitued;
    
    NSMutableDictionary*current_question_dictionary;
    BOOL is_in_question_editing_mode;//checks whether user currently editing question.
    
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UITabBarController *tabBarController;


@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSUserDefaults *user_defaults;

@property (nonatomic, retain) NSMutableDictionary *user_information_dictionary;

@property (nonatomic, readwrite) float current_latitude;
@property (nonatomic, readwrite) float current_longitued;

@property (nonatomic,retain)UIView* bottomView;
-(IBAction)buttonTabBarPressed:(id)sender;




@property (nonatomic,readwrite)float current_question_latitude;
@property (nonatomic,readwrite)float current_question_longitued;

@property (nonatomic,readwrite)BOOL is_in_question_editing_mode;


//Race Question information..
@property (nonatomic,retain)NSMutableArray*current_race_question_array;
@property (nonatomic,retain)NSMutableDictionary*current_question_dictionary;


+(BOOL)hasConnectivity;
@end
