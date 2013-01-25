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
    }
    return self;
}

-(IBAction)fb_button_pressed:(id)sender
{
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (![[delegate facebook] isSessionValid])
    {
        //[self showLoggedOut];
        //Not logged in...
        
        [self fb_login];
        
    }
    else
    {
        
        
       
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
    requestString = [NSString stringWithFormat:@"%@",[requestJSONDict JSONRepresentation]];
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
         
         NSLog(@"\n data = %@",[[responseDataDictionary objectForKey:@"d"] objectAtIndex:0]);
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];
    
    
    
    //email_registration_view.hidden = TRUE;
}

#pragma mark - 


#pragma mark - Start Email login methods


#pragma mark -  email_button_pressed

-(IBAction)email_button_pressed:(id)sender
{
    email_login_view.hidden = FALSE;
}


-(IBAction)email_create_account_button_pressed:(id)sender
{
    email_login_view.hidden = TRUE;
    user_registration_view.hidden = FALSE;
}

-(IBAction)email_login_login_button_pressed:(id)sender
{
    
    
    //user_registration
    
    
    requestObjects = [NSArray arrayWithObjects:@"login",email_registration,email_address_textField.text,password_textField.text,nil];
    requestkeys = [NSArray arrayWithObjects:@"action",@"registration_type",@"email",@"password",nil];
    
    requestJSONDict = [NSDictionary dictionaryWithObjects:requestObjects forKeys:requestkeys];
    //requestString = [NSString stringWithFormat:@"data=%@",[requestJSONDict JSONRepresentation]];
    requestString = [NSString stringWithFormat:@"%@",[requestJSONDict JSONRepresentation]];
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
         
         NSLog(@"\n data = %@",[[responseDataDictionary objectForKey:@"d"] objectAtIndex:0]);
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];
    
    
    
    //email_registration_view.hidden = TRUE;
}






-(IBAction)email_login_forgotPassword_button_pressed:(id)sender
{
    //email_login_view.hidden = TRUE;
}


-(IBAction)email_login_back_button_pressed:(id)sender
{
    email_login_view.hidden = TRUE;
}


-(void)enable_user_interaction
{
    
    [process_activity_indicator stopAnimating];
    process_activity_indicator.hidden = TRUE;
    
    
    NSLog(@"\n data = %@",responseDataDictionary);
    
        
    [self.view setUserInteractionEnabled:TRUE];
}








#pragma mark -  Email login methods

#pragma mark -

- (void)dealloc
{
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
	
}

#pragma mark - TextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
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
   
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return TRUE;
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
    
    NSLog(@"\n request did load result = %@",result);
    
    if ([result isKindOfClass:[NSArray class]])
    {
        result = [result objectAtIndex:0];
    }


    
}

/**
 * Called when an error prevents the Facebook API request from completing
 * successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"Err message: %@", [[error userInfo] objectForKey:@"error_msg"]);
    NSLog(@"Err code: %d", [error code]);
    
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
