//
//  CreateRaceViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CreateRaceViewController : UIViewController
{
    IBOutlet UIButton*create_race_Button;
    AppDelegate*app_delegate;
    IBOutlet UIWebView*youTube_video_webView;
   
    
    
    
}
-(IBAction)create_race_button_pressed:(id)sender;

@end
