//
//  ChooseLocationViewController.m
//  UltimageGeoTech
//
//  Created by Chirag@Sunshine on 06/02/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "ChooseLocationViewController.h"

@interface ChooseLocationViewController ()

@end

@implementation ChooseLocationViewController
@synthesize mapView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    latitude_label.text = [NSString stringWithFormat:@"%f",app_delegate.current_latitude];
    longitude_label.text = [NSString stringWithFormat:@"%f",app_delegate.current_longitued];
    mapView.showsUserLocation = YES;
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 1; //user needs to press for 1 seconds
    [self.mapView addGestureRecognizer:lpgr];
    [lpgr release];
    
    [self gotoLocation];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)gotoLocation
{
    // start off by default in San Francisco
   
    
    
    newRegion.center.latitude = app_delegate.current_question_latitude;
    newRegion.center.longitude = app_delegate.current_question_longitued;
    
    
    
    
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    [self.mapView setRegion:newRegion animated:YES];
    [mapView regionThatFits:newRegion];
}

- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan)
        return;
    
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D touchMapCoordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    
    NSLog(@"\n touchMapCoordinate lat = %f",touchMapCoordinate.latitude);
    NSLog(@"\n touchMapCoordinate  long = %f",touchMapCoordinate.longitude);
    
    latitude_label.text = [NSString stringWithFormat:@"%f",touchMapCoordinate.latitude];
    longitude_label.text = [NSString stringWithFormat:@"%f",touchMapCoordinate.longitude];
    
    app_delegate.current_question_latitude  = touchMapCoordinate.latitude;
    app_delegate.current_question_longitued = touchMapCoordinate.longitude;

    
}

-(IBAction)choose_location_pressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
