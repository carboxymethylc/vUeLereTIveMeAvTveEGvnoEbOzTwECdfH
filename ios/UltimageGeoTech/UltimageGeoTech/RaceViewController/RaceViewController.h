//
//  RaceViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import "AppDelegate.h"


@class MyAnnotation;
@interface RaceViewController : UIViewController<MKReverseGeocoderDelegate,MKMapViewDelegate, CLLocationManagerDelegate>
{
    IBOutlet MKMapView *mapView;
	MKPlacemark *mPlacemark;
	CLLocationCoordinate2D location;
    MyAnnotation *ann[100];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
    AppDelegate*app_delegate;
    
    
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
	//NSDictionary *responseDataDictionary;
    NSMutableArray *responseDataArray;//May be needed
    
    IBOutlet UIActivityIndicatorView*process_activity_indicator;
    


    
    
}

@property(nonatomic, retain) MKReverseGeocoder *geoCoder;


@end
