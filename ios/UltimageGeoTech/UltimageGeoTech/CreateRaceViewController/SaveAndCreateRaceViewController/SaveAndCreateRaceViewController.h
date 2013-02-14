//
//  SaveAndCreateRaceViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/13/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface SaveAndCreateRaceViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UITextField* race_name_text_field;//10001
    IBOutlet UITextField* show_number_of_question_text_field;//10002
    
    IBOutlet UITextView*race_detail_textView;//10003
    
    NSMutableDictionary*race_extra_detail_decitionary;
    
    AppDelegate*app_delegate;
    
    int current_textfield_textview_tag;
    
    
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
    
}

-(IBAction)create_race_button_clicked:(id)sender;
-(IBAction)share_race_button_clicked:(id)sender;

@end
