//
//  AccountViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "AccountViewController.h"



@implementation AccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Account", @"Account");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



-(void)viewWillAppear:(BOOL)animated
{
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    action_type = 1;
    
    
    
    
    
    requestObjects = [NSArray arrayWithObjects:
                      @"get_user_detail",
                      [app_delegate.user_information_dictionary objectForKey:@"user_id"],
                      nil];
    
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
                   @"user_id",
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
         
         
         
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_completed"] forKey:@"race_completed"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"race_created"] forKey:@"race_created"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"gps_rank"] forKey:@"gps_rank"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"full_name"] forKey:@"full_name"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"city"] forKey:@"city"];
         
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"email"] forKey:@"email"];
         
         [app_delegate.user_information_dictionary setObject:[responseDataDictionary objectForKey:@"user_name"] forKey:@"user_name"];
         
         
         
         
         NSLog(@"\n responseDataDictionary = %@",app_delegate.user_information_dictionary );
         
         
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];

    
    
    [super viewWillAppear:animated];
}


#pragma mark - enable_user_interaction

-(void)enable_user_interaction
{
    
    [process_activity_indicator stopAnimating];
    process_activity_indicator.hidden = TRUE;
    [self.view setUserInteractionEnabled:TRUE];
    
    if(action_type==1)
    {
        full_name_text_field.text = [app_delegate.user_information_dictionary objectForKey:@"full_name"];
        city_text_field.text =  [app_delegate.user_information_dictionary objectForKey:@"city"];
        email_label.text = [app_delegate.user_information_dictionary objectForKey:@"email"];
        user_name_label.text = [app_delegate.user_information_dictionary objectForKey:@"user_name"];
        races_completed_label.text =  [app_delegate.user_information_dictionary objectForKey:@"race_completed"];
        races_created_label.text = [app_delegate.user_information_dictionary objectForKey:@"race_created"];
        gps_rank_label.text = [app_delegate.user_information_dictionary objectForKey:@"gps_rank"];
    }
    else if(action_type == 2)
    {
        
        
        if([[responseDataDictionary objectForKey:@"STATUS"] intValue]==1)
        {
            UIAlertView*alertView = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Record updated successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            [alertView release];
        }
        else
        {
            UIAlertView*alertView = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Record update failed,please try again later." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alertView show];
            [alertView release];
        }
        
        
       
    }
    
    
    
    
    
    
}

#pragma mark - update_button_pressed

-(IBAction)update_button_pressed:(id)sender
{
    action_type = 2;
    
    [self.view bringSubviewToFront:process_activity_indicator];
    [self.view endEditing:TRUE];
    [self.view setUserInteractionEnabled:FALSE];
    
    
    requestObjects = [NSArray arrayWithObjects:
                      @"update_user_detail",
                      [app_delegate.user_information_dictionary objectForKey:@"user_id"],
                      full_name_text_field.text,
                      city_text_field.text,
                      password_text_field.text,
                      nil];
    
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
                   @"user_id",
                   @"full_name",
                   @"city",
                   @"password",
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
-(IBAction)logout_button_pressed:(id)sender
{
    [app_delegate.user_defaults setObject:@""forKey:@"user_id"];

    [app_delegate.tabBarController removeFromParentViewController];
    app_delegate.window.rootViewController =app_delegate.navigationController;
    [app_delegate.tabBarController setSelectedIndex:3];
    
    
}



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
    [textField resignFirstResponder];
    return TRUE;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
