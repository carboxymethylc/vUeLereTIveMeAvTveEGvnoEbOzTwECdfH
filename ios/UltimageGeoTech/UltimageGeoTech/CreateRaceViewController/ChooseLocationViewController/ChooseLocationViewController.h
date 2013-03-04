//
//  ChooseLocationViewController.h
//  UltimageGeoTech
//
//  Created by Chirag@Sunshine on 06/02/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"
@interface ChooseLocationViewController : UIViewController<MKMapViewDelegate>
{
    IBOutlet UILabel*latitude_label;
    IBOutlet UILabel*longitude_label;
    
     MKMapView *mapView;
    AppDelegate*app_delegate;
    
    MKCoordinateRegion newRegion;
    
}



@property (nonatomic, retain) IBOutlet MKMapView *mapView;

-(IBAction)choose_location_pressed:(id)sender;


- (void)gotoLocation;
@end
