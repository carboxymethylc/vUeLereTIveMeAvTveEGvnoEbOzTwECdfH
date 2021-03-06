//
//  DetailViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 1/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
@interface HomeScreenViewController : UIViewController<CLLocationManagerDelegate,UITextViewDelegate>
{
    CLLocationManager *locationManager;
    
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
    NSMutableArray *responseDataArray;//May be needed
    
    IBOutlet UIActivityIndicatorView*process_activity_indicator;

    AppDelegate*app_delegate;
    
    IBOutlet UITextView*news_textView;
    int action_type;//1 for getting news,2 for current location
    
    
}
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
