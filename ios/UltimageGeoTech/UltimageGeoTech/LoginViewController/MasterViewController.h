//
//  MasterViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 1/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "AppDelegate.h"
#import "JSON.h"


@interface MasterViewController : UIViewController<FBRequestDelegate,FBDialogDelegate,FBSessionDelegate,UITextFieldDelegate>
{
    IBOutlet UIView*email_registration_view;
    
    IBOutlet UIButton*fb_button;
    IBOutlet UIButton*email_button;
    
    IBOutlet UITextField*email_address_textField;
    IBOutlet UITextField*password_textField;
    
    //fb permission array
    NSArray *permissions;
    
    
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

-(IBAction)fb_button_pressed:(id)sender;
-(IBAction)email_button_pressed:(id)sender;

//Facebook
- (void)fb_login;
- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt;
- (void)apiFQLIMe;
@property (nonatomic, retain) NSArray *permissions;


//


-(IBAction)email_reg_back_button_pressed:(id)sender;
-(IBAction)email_reg_registration_button_pressed:(id)sender;
-(IBAction)email_reg_login_button_pressed:(id)sender;
-(IBAction)email_reg_forgotPassword_button_pressed:(id)sender;

@end
