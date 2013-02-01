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
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) UITabBarController *tabBarController;


@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) NSUserDefaults *user_defaults;
+(BOOL)hasConnectivity;
@end
