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
    IBOutlet UIView*email_login_view;
    IBOutlet UIView*user_registration_view;
    
    IBOutlet UIButton*fb_button;
    IBOutlet UIButton*email_button;
    
    //email login
    IBOutlet UITextField*email_address_textField;
    IBOutlet UITextField*password_textField;
    
    
    //email registration
    IBOutlet UITextField*registration_fullname_textField;
    IBOutlet UITextField*registration_email_address_textField;
    IBOutlet UITextField*registration_password_textField;
    IBOutlet UITextField*registration_city_textField;
    
    

    
    
    
    
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
    
    int action_type;//1=registration,2=forgotpassword,3= login,4= connect with fb(this includes registration + login)
    
    AppDelegate*appDelegate;
    
}

-(IBAction)fb_button_pressed:(id)sender;
-(IBAction)email_button_pressed:(id)sender;

//Facebook
- (void)fb_login;
- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt;
- (void)apiFQLIMe;
@property (nonatomic, retain) NSArray *permissions;


//
-(IBAction)email_create_account_button_pressed:(id)sender;

-(IBAction)email_reg_back_button_pressed:(id)sender;
-(IBAction)email_login_back_button_pressed:(id)sender;
-(IBAction)email_reg_registration_button_pressed:(id)sender;

-(IBAction)email_login_login_button_pressed:(id)sender;
-(IBAction)email_login_forgotPassword_button_pressed:(id)sender;

/*checks whether current user is already registerd.
 if Not,then registering new user and redirecting in home screen
 if Yes,then redirecting in home screen.
 */
-(IBAction)check_fb_user_registration;



@end
