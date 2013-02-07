//
//  AccountViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AccountViewController : UIViewController<UITextFieldDelegate>
{
    IBOutlet UITextField*full_name_text_field;
    IBOutlet UILabel*user_name_label;
    IBOutlet UITextField*password_text_field;
    IBOutlet UITextField*city_text_field;
    IBOutlet UILabel*email_label;
    IBOutlet UILabel*races_completed_label;
    IBOutlet UILabel*races_created_label;
    IBOutlet UILabel*gps_rank_label;
    AppDelegate*app_delegate;
    
    IBOutlet UIScrollView*accountView_scrollView;
    
    //variabales for Webservices
    
    
    NSArray *requestObjects;
	NSArray *requestkeys;
	NSDictionary *requestJSONDict;
	NSMutableDictionary *finalJSONDictionary;
	NSString *jsonRequest;
	NSString *requestString;
	NSData *requestData;
	NSString *urlString;
	NSMutableURLRequest *request;
	NSData *returnData;
	NSError *error;
	SBJSON *json;
	NSDictionary *responseDataDictionary;
    //NSMutableArray *responseDataArray;//May be needed
    
    IBOutlet UIActivityIndicatorView*process_activity_indicator;
    
    int action_type;//1 for fetching information.2 for updating 
    
    
    
    
}

-(IBAction)update_button_pressed:(id)sender;
-(IBAction)logout_button_pressed:(id)sender;
@end
