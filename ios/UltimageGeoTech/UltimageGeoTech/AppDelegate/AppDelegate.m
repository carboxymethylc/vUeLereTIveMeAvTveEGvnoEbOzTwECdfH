//
//  AppDelegate.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 1/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "AppDelegate.h"

#import "MasterViewController.h"

#import "HomeScreenViewController.h"
#import "AccountViewController.h"
#import "CreateRaceViewController.h"
#import "RaceViewController.h"
#import "ScoreViewController.h"


#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>

@implementation AppDelegate
@synthesize facebook,user_defaults;
@synthesize user_information_dictionary;

@synthesize current_longitued,current_latitude;

static NSString* kAppId = @"401301426565681";


- (void)dealloc
{
    [_window release];
    [_navigationController release];
    [_tabBarController release];
    [user_information_dictionary release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.

    
    user_information_dictionary = [[NSMutableDictionary alloc] init];
    
    
    MasterViewController *masterViewController = [[[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //HomeScreenViewController
    
    HomeScreenViewController *homeScreenViewController = [[[HomeScreenViewController alloc] initWithNibName:@"HomeScreenViewController" bundle:nil] autorelease];
    
    UINavigationController*homeScreenNavController =  [[[UINavigationController alloc] initWithRootViewController:homeScreenViewController] autorelease];
    
    [homeScreenNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    

    //AccountViewController
    
    AccountViewController *accountViewController = [[[AccountViewController alloc] initWithNibName:@"AccountViewController" bundle:nil] autorelease];
    
    UINavigationController*accountScreenNavController =  [[[UINavigationController alloc] initWithRootViewController:accountViewController] autorelease];
    
    [accountScreenNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    //CreateRaceViewController
    
    CreateRaceViewController *createRaceViewController = [[[CreateRaceViewController alloc] initWithNibName:@"CreateRaceViewController" bundle:nil] autorelease];
    
    UINavigationController*createRaceNavController =  [[[UINavigationController alloc] initWithRootViewController:createRaceViewController] autorelease];
    
    [createRaceNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];

    
    //RaceViewController
    RaceViewController *raceViewController = [[[RaceViewController alloc] initWithNibName:@"RaceViewController" bundle:nil] autorelease];
    
    UINavigationController*raceViewNavController =  [[[UINavigationController alloc] initWithRootViewController:raceViewController] autorelease];
    
    [raceViewNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];

    
    //ScoreViewController
    
    ScoreViewController *scoreViewController = [[[ScoreViewController alloc] initWithNibName:@"ScoreViewController" bundle:nil] autorelease];
    
    UINavigationController*scoreViewNavController =  [[[UINavigationController alloc] initWithRootViewController:scoreViewController] autorelease];
    
    [scoreViewNavController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_navigation_bar.png"] forBarMetrics:UIBarMetricsDefault];
    
    



    
    
    
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:
                                             raceViewNavController,
                                            createRaceNavController,
                                             scoreViewNavController,
                                            homeScreenNavController, 
                                            accountScreenNavController,
                                              nil];

    
    
    self.tabBarController.selectedIndex = 3;
   
    
    /*
     Facebook methods starts
     */
    
    // Initialize Facebook
    
    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:masterViewController];
    
    // Check and retrieve authorization information
    user_defaults =[NSUserDefaults standardUserDefaults];
    if ([user_defaults objectForKey:@"FBAccessTokenKey"] && [user_defaults objectForKey:@"FBExpirationDateKey"])
    {
        facebook.accessToken = [user_defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [user_defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    
    if (!kAppId)
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Setup Error"
                                  message:@"Missing app ID. You cannot run the app until you provide this in the code."
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil,
                                  nil];
        [alertView show];
        [alertView release];
    } else
    {
        // Now check that the URL scheme fb[app_id]://authorize is in the .plist and can
        // be opened, doing a simple check without local app id factored in here
        NSString *url = [NSString stringWithFormat:@"fb%@://authorize",kAppId];
        BOOL bSchemeInPlist = NO; // find out if the sceme is in the plist file.
        NSArray* aBundleURLTypes = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleURLTypes"];
        if ([aBundleURLTypes isKindOfClass:[NSArray class]] &&
            ([aBundleURLTypes count] > 0))
        {
            NSDictionary* aBundleURLTypes0 = [aBundleURLTypes objectAtIndex:0];
            if ([aBundleURLTypes0 isKindOfClass:[NSDictionary class]])
            {
                NSArray* aBundleURLSchemes = [aBundleURLTypes0 objectForKey:@"CFBundleURLSchemes"];
                if ([aBundleURLSchemes isKindOfClass:[NSArray class]] &&
                    ([aBundleURLSchemes count] > 0))
                {
                    NSString *scheme = [aBundleURLSchemes objectAtIndex:0];
                    if ([scheme isKindOfClass:[NSString class]] &&
                        [url hasPrefix:scheme])
                    {
                        bSchemeInPlist = YES;
                    }
                }
            }
        }
        // Check if the authorization callback will work
        BOOL bCanOpenUrl = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: url]];
        if (!bSchemeInPlist || !bCanOpenUrl) {
            UIAlertView *alertView = [[UIAlertView alloc]
                                      initWithTitle:@"Setup Error"
                                      message:@"Invalid or missing URL scheme. You cannot run the app until you set up a valid URL scheme in your .plist."
                                      delegate:self
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil,
                                      nil];
            [alertView show];
            [alertView release];
        }
    }

    /*
     Facebook methods ends
     */

    
    //[[self navigationController] setNavigationBarHidden:YES animated:NO];
    
    self.tabBarController.delegate = self;
    //[self.tabBarController.tabBar setHidden:YES];
    
    //[self.window addSubview:self.tabBarController.view];
    //self.window.rootViewController =self.tabBarController;
    
    
    
    
    NSLog(@"\n user id = %@",[user_defaults objectForKey:@"user_id"]);

    
    if([user_defaults objectForKey:@"user_id"]!=nil && [[[user_defaults objectForKey:@"user_id"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]>0)
    {
        [user_information_dictionary setObject:[user_defaults objectForKey:@"user_id"] forKey:@"user_id"];
        self.window.rootViewController =self.tabBarController;
    }
    else
    {
        self.window.rootViewController = self.navigationController;
    }
    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+(BOOL)hasConnectivity
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}


@end
