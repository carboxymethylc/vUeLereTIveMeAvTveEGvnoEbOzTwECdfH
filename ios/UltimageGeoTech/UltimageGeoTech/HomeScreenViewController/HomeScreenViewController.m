//
//  DetailViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 1/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "HomeScreenViewController.h"



@implementation HomeScreenViewController
@synthesize locationManager;
- (void)dealloc
{
   
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Home", @"Home");
        [[self navigationItem] setTitle:@"UTLTIMATE GT"];
        [self.tabBarItem setTitle:@"Home"];
        
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
    
    [self.view bringSubviewToFront:process_activity_indicator];
    [self.view endEditing:TRUE];
    [self.view setUserInteractionEnabled:FALSE];
    
    action_type = 1;
    requestObjects = [NSArray arrayWithObjects:
                      @"get_latest_news",
                      nil];
    
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
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
    
    
    /*here we need sendSynchronousRequest*/
    returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil ]; // send data to the web service
    
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	
	NSLog(@"\n returnString == %@",returnString);
	
	json = [[SBJSON new] autorelease];
	
	responseDataArray = [json objectWithString:returnString error:&error];
    [responseDataArray retain];
    NSLog(@"\n responseDataDictionary = %@ ",responseDataArray);
    news_textView.text = [[responseDataArray objectAtIndex:0] objectForKey:@"news"];
    [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];

    
    
    /*
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSLog(@"\n response we get = %@",response);
         returnData = data;
         NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
         NSLog(@"\n returnString == %@",returnString);
         json = [[SBJSON new] autorelease];
         
         
         responseDataArray = [json objectWithString:returnString error:&error];
         [responseDataArray retain];
         
         NSLog(@"\n responseDataArray = %@",responseDataArray);
        // news_textView.text = [[responseDataArray objectAtIndex:0] objectForKey:@"news"];
         
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];
*/
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    locationManager.delegate = self;
    // This is the most important property to set for the manager. It ultimately determines how the manager will
    // attempt to acquire location and thus, the amount of power that will be consumed.
    locationManager.desiredAccuracy =kCLLocationAccuracyBest ;
    // When "tracking" the user, the distance filter can be used to control the frequency with which location measurements
    // are delivered by the manager. If the change in distance is less than the filter, a location will not be delivered.
    locationManager.distanceFilter = 300.0f;
    // Once configured, the location manager must be "started".
    [locationManager startUpdatingLocation];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"\n newLocation.coordinate.latitude = %f",newLocation.coordinate.latitude);
    NSLog(@"\n newLocation.coordinate.longitude = %f",newLocation.coordinate.longitude);
    
    app_delegate.current_latitude = newLocation.coordinate.latitude;
    app_delegate.current_longitued = newLocation.coordinate.longitude;
    action_type = 2;
    
    //[locationManager stopUpdatingLocation];
    
    //testing
    
    [app_delegate.user_information_dictionary setObject:@"1" forKey:@"user_id"];
    
    requestObjects = [NSArray arrayWithObjects:
                      @"update_user_location",
                      [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude],
                      [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude],
                      [app_delegate.user_information_dictionary objectForKey:@"user_id"],
                      nil];
    
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
                   @"user_latitude",
                   @"user_longitude",
                   @"user_id",
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
         
         NSLog(@"\n responseDataArray = %@",responseDataDictionary);
         
         
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];
    

    
    
    
    
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error_location_manager
{
    // The location "unknown" error simply means the manager is currently unable to get the location.
    NSLog(@"\n error_local = %@",[error_location_manager localizedDescription]);
    if ([error_location_manager code] != kCLErrorLocationUnknown)
    {
        
    }
}


-(void)enable_user_interaction
{
    NSLog(@"action type = %d",action_type);
    
    
    if(action_type==1)
    {
        news_textView.text = [[responseDataArray objectAtIndex:0] objectForKey:@"news"];
    }
    
    [process_activity_indicator stopAnimating];
    process_activity_indicator.hidden = TRUE;
    [self.view setUserInteractionEnabled:TRUE];

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


							
@end
