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

+(BOOL)hasConnectivity;
@end
