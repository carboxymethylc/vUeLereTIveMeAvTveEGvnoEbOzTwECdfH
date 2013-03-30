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
@interface RaceViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate>
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
    

    IBOutlet UITableView*search_filter_tableView;
    
    NSMutableArray*filter_types;
    NSMutableDictionary*checked_filters;
    NSMutableArray*tableView_cell_array;
    IBOutlet UIView*search_view;
    UIButton * filter_button;
    
    
    NSMutableArray*search_filters;
    int current_request_type;
    
    NSMutableArray*all_questions_index;
    
    NSMutableArray*final_question_array;
    
    NSMutableArray*initial_question_array;
    
    
}


-(IBAction)search_done_button_pressed:(id)sender;
@property(nonatomic,retain)NSMutableArray*search_filters;

@end
