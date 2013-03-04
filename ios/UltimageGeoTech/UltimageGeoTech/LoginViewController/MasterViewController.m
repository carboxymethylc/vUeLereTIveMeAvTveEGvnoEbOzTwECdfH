//
//  MasterViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 1/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "MasterViewController.h"

@implementation MasterViewController
@synthesize permissions;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Login", @"Login");
        [[self navigationItem] setTitle:@"UTLTIMATE GT"];
    }
    return self;
}

-(IBAction)fb_button_pressed:(id)sender
{
    /*testing only..
    [app_delegate.navigationController removeFromParentViewController];
    app_delegate.window.rootViewController =app_delegate.tabBarController;
    return;
    */
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid])
    {
        //[self showLoggedOut];
        //Not logged in...
        
        [self fb_login];
        
    }
    else
    {
        [self check_fb_user_registration];
    }
    
}

#pragma mark - Start email_reg_registration_button_pressed


-(IBAction)email_reg_back_button_pressed:(id)sender
{
    user_registration_view.hidden = TRUE;
    email_login_view.hidden = FALSE;
}

-(IBAction)email_reg_registration_button_pressed:(id)sender
{
    
    
    //user_registration
    
    action_type = 1;
    requestObjects = [NSArray arrayWithObjects:
                      @"user_registration",
                      email_registration,
                      registration_fullname_textField.text,
                      registration_email_address_textField.text,
                      registration_email_address_textField.text,
                      registration_password_textField.text,
                      registration_city_textField.text,
                      nil];
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
                   @"registration_type",
                   @"full_name",
                   @"user_name",
                   @"email",
                   @"password",
                   @"city",
                   nil];
    
    requestJSONDict = [NSDictionary dictionaryWithObjects:requestObjects forKeys:requestkeys];
    //requestString = [NSString stringWithFormat:@"data=%@",[requestJSONDict JSONRepresentation]];
    requestString = [NSString stringWithFormat:@"data=%@",[requestJSONDict JSONRepresentation]];
    NSLog(@"\n \n \n \n \n \n ");
    
    NSLog(@"\n requestString = %@",requestString);
    
    requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
    urlString = [NSString stringWithFormat:@"%@",WEB_SERVICE_URL];
    NSLog(@"\n urlString = %@",urlString);
    request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]]; // set URL for the request
    [request setHTTPMethod:@"POST"]; // set method the request
    
    
    [request setHTTPBody:requestData];
    
    
    
    process_activity_indicator.hidden = FALSE;
    [process_activity_indicator startAnimating];
    [self.view bringSubviewToFront:process_activity_indicator];
    [self.view endEditing:TRUE];
    [self.view setUserInteractionEnabled:FALSE];
    
    
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSLog(@"\n response we get = %@",response);
         returnData = data;
         NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
         NSLog(@"\n returnString == %@",returnString);
         json = [[SBJSON new] autorelease];
         
         
         responseDataDictionary = [json objectWithString:returnString error:&error];
         [responseDataDictionary retain];
         
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_completed"] forKey:@"race_completed"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_created"] forKey:@"race_created"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"gps_rank"] forKey:@"gps_rank"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"full_name"] forKey:@"full_name"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"city"] forKey:@"city"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"email"] forKey:@"email"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"user_name"] forKey:@"user_name"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"id"] forKey:@"user_id"];

         
         [app_delegate.user_defaults setObject:[responseDataDictionary objectForKey:@"id"] forKey:@"user_id"];
         [app_delegate.user_defaults synchronize];

         
         
         NSLog(@"\n responseDataDictionary = %@",responseDataDictionary);
         
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];
    
    
    
    //email_registration_view.hidden = TRUE;
}




#pragma mark - Start Email login methods


#pragma mark -  email_button_pressed

-(IBAction)email_button_pressed:(id)sender
{
    email_login_view.hidden = FALSE;
}


-(IBAction)email_create_account_button_pressed:(id)sender
{

    /*
    [app_delegate.navigationController removeFromParentViewController];
    app_delegate.window.rootViewController =app_delegate.tabBarController;
    */
     
    email_login_view.hidden = TRUE;
    user_registration_view.hidden = FALSE;
}

-(IBAction)email_login_login_button_pressed:(id)sender
{
    
    
    //user_registration
    
    action_type = 3;
    requestObjects = [NSArray arrayWithObjects:@"login",email_registration,email_address_textField.text,password_textField.text,nil];
    requestkeys = [NSArray arrayWithObjects:@"action",@"registration_type",@"email",@"password",nil];
    
    requestJSONDict = [NSDictionary dictionaryWithObjects:requestObjects forKeys:requestkeys];
    requestString = [NSString stringWithFormat:@"data=%@",[requestJSONDict JSONRepresentation]];
    NSLog(@"\n \n \n \n \n \n ");
    
    NSLog(@"\n requestString = %@",requestString);
    
    requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
    urlString = [NSString stringWithFormat:@"%@",WEB_SERVICE_URL];
    NSLog(@"\n urlString = %@",urlString);
    request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]]; // set URL for the request
    [request setHTTPMethod:@"POST"]; // set method the request
    
    
    [request setHTTPBody:requestData];
    
    
    
    process_activity_indicator.hidden = FALSE;
    [self.view bringSubviewToFront:process_activity_indicator];
    [process_activity_indicator startAnimating];
    [self.view endEditing:TRUE];
    [self.view setUserInteractionEnabled:FALSE];
    
    
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSLog(@"\n response we get = %@",response);
         returnData = data;
         NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
         NSLog(@"\n returnString == %@",returnString);
         json = [[SBJSON new] autorelease];
         
         
         responseDataDictionary = [json objectWithString:returnString error:&error];
         [responseDataDictionary retain];
         
         NSLog(@"\n responseDataDictionary = %@",responseDataDictionary);
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_completed"] forKey:@"race_completed"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_created"] forKey:@"race_created"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"gps_rank"] forKey:@"gps_rank"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"full_name"] forKey:@"full_name"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"city"] forKey:@"city"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"email"] forKey:@"email"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"user_name"] forKey:@"user_name"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"id"] forKey:@"user_id"];
         
         
         [app_delegate.user_defaults setObject:[responseDataDictionary objectForKey:@"id"] forKey:@"user_id"];
         [app_delegate.user_defaults synchronize];

         
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];
    
    
    
    //email_registration_view.hidden = TRUE;
}






-(IBAction)email_login_forgotPassword_button_pressed:(id)sender
{
    //email_login_view.hidden = TRUE;
    
   
    /*
    UIAlertView*forgotPassword_alertView = [[UIAlertView alloc] initWithTitle:@"Please enter your user name" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    */
    
    
    UIAlertView*forgotPassword_alertView = [[UIAlertView alloc] init];
    
    
    
    forgotPassword_textField.borderStyle = UITextBorderStyleRoundedRect;
    forgotPassword_textField.keyboardAppearance = UIKeyboardAppearanceAlert;
    forgotPassword_textField.delegate = self;
    [forgotPassword_alertView addSubview:forgotPassword_textField];
    
    forgotPassword_alertView.title = @"Please enter your username\n\n\n";
    forgotPassword_alertView.tag = 998;
    forgotPassword_alertView.message = nil;
    forgotPassword_alertView.delegate = self;
    [forgotPassword_alertView addButtonWithTitle:@"Cancel"];
    [forgotPassword_alertView addButtonWithTitle:@"Ok"];
    //[forgotPassword_alertView addButtonWithTitle:nil];
    
    
    [forgotPassword_alertView show];
    [forgotPassword_alertView release];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"\n buttonIndex = %d",buttonIndex);
    
    if(alertView.tag == 998)
    {
        
        if(buttonIndex != 1)
        {
            
            return;
        }
        
        action_type = 2;
        
        
        requestObjects = [NSArray arrayWithObjects:@"forgotpassword",
                          forgotPassword_textField.text,nil];
        requestkeys = [NSArray arrayWithObjects:@"action",
                       @"user_name",
                       nil];
        
        requestJSONDict = [NSDictionary dictionaryWithObjects:requestObjects forKeys:requestkeys];
        requestString = [NSString stringWithFormat:@"data=%@",[requestJSONDict JSONRepresentation]];
        NSLog(@"\n \n \n \n \n \n ");
        
        NSLog(@"\n requestString = %@",requestString);
        
        requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
        urlString = [NSString stringWithFormat:@"%@",WEB_SERVICE_URL];
        NSLog(@"\n urlString = %@",urlString);
        request = [[[NSMutableURLRequest alloc] init] autorelease];
        [request setURL:[NSURL URLWithString:urlString]]; // set URL for the request
        [request setHTTPMethod:@"POST"]; // set method the request
        
        
        [request setHTTPBody:requestData];
        
        
        
        process_activity_indicator.hidden = FALSE;
        [self.view bringSubviewToFront:process_activity_indicator];
        [process_activity_indicator startAnimating];
        [self.view endEditing:TRUE];
        [self.view setUserInteractionEnabled:FALSE];
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             NSLog(@"\n response we get = %@",response);
             returnData = data;
             NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
             NSLog(@"\n returnString == %@",returnString);
             json = [[SBJSON new] autorelease];
             
             
             responseDataDictionary = [json objectWithString:returnString error:&error];
             [responseDataDictionary retain];
             
             NSLog(@"\n responseDataDictionary = %@",responseDataDictionary);
             
             [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
             
             
             
         }];
        
        [queue release];

        
        
        
    }
    
    
    
    
    
    
}

- (void)willPresentAlertView:(UIAlertView *)alertView
{
    //[alertView setFrame:CGRectMake(0, 0,275,200)];
    
}

-(IBAction)email_login_back_button_pressed:(id)sender
{
    email_login_view.hidden = TRUE;
}

#pragma mark -  enable_user_interaction

-(void)enable_user_interaction
{
    
    [process_activity_indicator stopAnimating];
    process_activity_indicator.hidden = TRUE;
    [self.view setUserInteractionEnabled:TRUE];
    NSLog(@"\n data = %d",action_type);
    NSLog(@"\n responseDataDictionary = %@",responseDataDictionary);
    

    switch (action_type)
    {
            
        case 2://forgotpassword
        {
            
            UIAlertView*forgotPassword = [[UIAlertView alloc] initWithTitle:@"" message:[responseDataDictionary objectForKey:@"MESSAGE"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            forgotPassword.tag = 999;
            [forgotPassword show];
            [forgotPassword release];
            
            return;
            
        }
            
        case 4:
        {
            //Fb login or registration
            break;

        }
            
        default:
            break;
    }
    
    [app_delegate.navigationController removeFromParentViewController];
    app_delegate.window.rootViewController =app_delegate.tabBarController;
    
    /*
    UIAlertView*alertView = [[UIAlertView alloc] initWithTitle:@"" message:[responseDataDictionary objectForKey:@"MESSAGE"] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
    [alertView release];
    */
    
        
    
}








#pragma mark -  Email login methods

#pragma mark -

- (void)dealloc
{
    [forgotPassword_textField release];
    [super dealloc];
}

#pragma mark -  viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    permissions = [[NSArray alloc]
                   initWithObjects:@"offline_access,publish_stream",@"email", nil];
    //[self.view addSubview:email_registration_view];
    email_login_view.hidden = TRUE;
    user_registration_view.hidden = TRUE;
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
	email_reg_scrollView.contentSize = CGSizeMake(320,500);
    
    forgotPassword_textField = [[UITextField alloc] initWithFrame:CGRectMake(10,50,260,30)];
    
    
    
}

#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    email_reg_scrollView.contentSize = CGSizeMake(320,700);
    
    return TRUE;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return TRUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
       email_reg_scrollView.contentSize = CGSizeMake(320,500);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}

#pragma mark -

#pragma mark -  check_fb_user_registration



-(void)check_fb_user_registration
{
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSLog(@"\n name = %@",[app_delegate.user_defaults objectForKey:@"name"]);
     NSLog(@"\n name = %@",[app_delegate.user_defaults objectForKey:@"fb_email"]);
     NSLog(@"\n name = %@",[app_delegate.user_defaults objectForKey:@"fb_uid"]);
    
    action_type = 4;
    requestObjects = [NSArray arrayWithObjects:
                      @"fb_user_registration_login",
                      [app_delegate.user_defaults objectForKey:@"fb_name"],
                      [app_delegate.user_defaults objectForKey:@"fb_email"],
                      [NSString stringWithFormat:@"%@",[app_delegate.user_defaults objectForKey:@"fb_uid"]],
                      nil];
    
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
                   @"full_name",
                   @"email",
                   @"fb_id",
                nil];
    
    
    NSLog(@"\n requestObjects = %@",requestObjects);
    
    requestJSONDict = [NSDictionary dictionaryWithObjects:requestObjects forKeys:requestkeys];
    
    requestString = [NSString stringWithFormat:@"data=%@",[requestJSONDict JSONRepresentation]];
    NSLog(@"\n \n \n \n \n \n ");
    
    NSLog(@"\n requestString = %@",requestString);
    
    requestData = [NSData dataWithBytes: [requestString UTF8String] length: [requestString length]];
    urlString = [NSString stringWithFormat:@"%@",WEB_SERVICE_URL];
    NSLog(@"\n urlString = %@",urlString);
    request = [[[NSMutableURLRequest alloc] init] autorelease];
    [request setURL:[NSURL URLWithString:urlString]]; // set URL for the request
    [request setHTTPMethod:@"POST"]; // set method the request
    
    
    [request setHTTPBody:requestData];
    
    
    
    process_activity_indicator.hidden = FALSE;
    [process_activity_indicator startAnimating];
    [self.view bringSubviewToFront:process_activity_indicator];
    [self.view endEditing:TRUE];
    [self.view setUserInteractionEnabled:FALSE];
    
    
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSLog(@"\n response we get = %@",response);
         returnData = data;
         NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
         NSLog(@"\n returnString == %@",returnString);
         json = [[SBJSON new] autorelease];
         
         
         responseDataDictionary = [json objectWithString:returnString error:&error];
         [responseDataDictionary retain];
         
         NSLog(@"\n responseDataDictionary = %@",responseDataDictionary);
         
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_completed"] forKey:@"race_completed"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_created"] forKey:@"race_created"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"gps_rank"] forKey:@"gps_rank"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"full_name"] forKey:@"full_name"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"city"] forKey:@"city"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"email"] forKey:@"email"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"user_name"] forKey:@"user_name"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"id"] forKey:@"user_id"];
         
         
         [app_delegate.user_defaults setObject:[responseDataDictionary objectForKey:@"id"] forKey:@"user_id"];
         [app_delegate.user_defaults synchronize];
         
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];

    
    
}

#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  FBStarts
//Facebook starts
#pragma mark - fb_login Method
- (void)fb_login
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid])
    {
        [[delegate facebook] authorize:permissions];
    }
    
}


#pragma mark - FBRequestDelegate Methods
/**
 * Called when the Facebook API request has returned a response.
 *
 * This callback gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"received response");
}

/**
 * Called when a request returns and its response has been parsed into
 * an object.
 *
 * The resulting object may be a dictionary, an array or a string, depending
 * on the format of the API response. If you need access to the raw response,
 * use:
 *
 * (void)request:(FBRequest *)request
 *      didReceiveResponse:(NSURLResponse *)response
 */
- (void)request:(FBRequest *)request didLoad:(id)result
{
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSLog(@"\n request did load result = %@",result);
    
    if ([result isKindOfClass:[NSArray class]])
    {
        result = [result objectAtIndex:0];
    }

    
    NSLog(@"\n user registered/signup using fb..now we need to ");
    NSLog(@"\n resutl for user = %@",result);
    
    NSLog(@"\n email for user = %@",[result objectForKey:@"email"]);
    NSLog(@"\n first_name for user = %@",[result objectForKey:@"first_name"]);
    NSLog(@"\n last_name for user = %@",[result objectForKey:@"last_name"]);
    NSLog(@"\n name for user = %@",[result objectForKey:@"name"]);
    NSLog(@"\n uid for user = %@",[result objectForKey:@"uid"]);
    
    [app_delegate.user_defaults setObject:[result objectForKey:@"email"] forKey:@"fb_email"];
    [app_delegate.user_defaults setObject:[result objectForKey:@"name"] forKey:@"fb_name"];
    [app_delegate.user_defaults setObject:[result objectForKey:@"uid"] forKey:@"fb_uid"];
    [app_delegate.user_defaults synchronize];
    
    [self check_fb_user_registration];
    
    
//user_defaults
    
    
    
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)fb_error
{
    NSLog(@"Err message: %@", [[fb_error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [fb_error code]);
    
}


- (void)storeAuthData:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

#pragma mark - FBSessionDelegate Methods
/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin
{
    NSLog(@"fbDidLogin");
    
    AppDelegate *delegateFB = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [self storeAuthData:[[delegateFB facebook] accessToken] expiresAt:[[delegateFB facebook] expirationDate]];
    
    [self apiFQLIMe];
    
}


- (void)apiFQLIMe
{
    // Using the "pic" picture since this currently has a maximum width of 100 pixels
    // and since the minimum profile picture size is 180 pixels wide we should be able
    // to get a 100 pixel wide version of the profile picture
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"SELECT uid, name,email,pic FROM user WHERE uid=me()", @"query",
                                   nil];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query"
                                     andParams:params
                                 andHttpMethod:@"POST"
                                   andDelegate:self];
}

- (void)apiGraphUserPermissions
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/permissions" andDelegate:self];
}



-(void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt
{
    NSLog(@"token extended");
    [self storeAuthData:accessToken expiresAt:expiresAt];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled
{
    
    
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout
{
    // Remove saved authorization information if it exists and it is
    // ok to clear it (logout, session invalid, app unauthorized)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
}

/**
 * Called when the session has expired.
 */
- (void)fbSessionInvalidated {
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Auth Exception"
                              message:@"Your session has expired."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil,
                              nil];
    [alertView show];
    
    
    
    [self fbDidLogout];
}


#pragma mark -  FB Ends


@end
