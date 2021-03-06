//
//  MyAnnotation.h
//  Map
//
//  Created by Palak Patel on 12/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>

@interface MyAnnotation : NSObject <MKAnnotation> 
{
	CLLocationCoordinate2D coordinate;
	NSString *title;
    NSString *subtitle;
	UIImage  *img;
    NSMutableDictionary*race_detail_dictioanary;
    int currentPoint;
	int curId;
	
	
	
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property(nonatomic, retain) UIImage *img;
@property(nonatomic, readwrite) int currentPoint;
@property(nonatomic,readwrite)int curId;

@property(nonatomic,retain)NSMutableDictionary*race_detail_dictioanary;


@end
