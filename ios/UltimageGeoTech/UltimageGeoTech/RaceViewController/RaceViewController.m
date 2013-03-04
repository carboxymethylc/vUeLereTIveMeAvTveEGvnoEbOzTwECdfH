//
//  RaceViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "RaceViewController.h"
#import "MyAnnotation.h"
@interface RaceViewController ()

@end

@implementation RaceViewController
@synthesize geoCoder;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
         self.title = NSLocalizedString(@"Race", @"Race");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView.mapType = MKMapTypeStandard;
	mapView.showsUserLocation = YES;
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    /*
    geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:mapView.userLocation.location.coordinate];
	
	geoCoder.delegate=self;
	[geoCoder start];
	*/
    
    
    
    
    
	


    
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    
    CLLocationCoordinate2D location2 = mapView.userLocation.coordinate;
	location2.latitude=app_delegate.current_latitude;
	location2.longitude=app_delegate.current_longitued;
    

    /*
    region.span=span;
    region.center=location2;
    */
    
    region.center.latitude = app_delegate.current_question_latitude;
    region.center.longitude = app_delegate.current_question_longitued;
    
    
    
    
    region.span.latitudeDelta = 0.112872;
    region.span.longitudeDelta = 0.109863;
    
    
    
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
    
    NSLog(@"\n  user Info. dic = %@",app_delegate.user_information_dictionary);
       
    
    requestObjects = [NSArray arrayWithObjects:
                      @"get_near_by_races",
                      [NSNumber numberWithFloat:app_delegate.current_latitude],
                      [NSNumber numberWithFloat:app_delegate.current_longitued],
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
         
         
         responseDataArray = [json objectWithString:returnString error:&error];
         [responseDataArray retain];
         
         NSLog(@"\n responseDataArray = %@",responseDataArray);
         
         
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
    
    //race_latitude
    //race_longitude
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        MyAnnotation *annotation =  [[MyAnnotation alloc] init];
        
      
        
        annotation.coordinate = CLLocationCoordinate2DMake([[[responseDataArray objectAtIndex:i] objectForKey:@"race_latitude"] floatValue],[[[responseDataArray objectAtIndex:i] objectForKey:@"race_longitude"] floatValue]);
        annotation.currentPoint = 1;
        
       
        
        
        
        annotation.title= [[responseDataArray objectAtIndex:i] objectForKey:@"race_name"];
        annotation.subtitle = [[responseDataArray objectAtIndex:i] objectForKey:@"race_info"];
        annotation.curId= [[[responseDataArray objectAtIndex:i] objectForKey:@"id"] intValue];
        [mapView addAnnotation:annotation];
        [annotation release];

    }
    
    
    
    
    
    [self.view setUserInteractionEnabled:TRUE];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
