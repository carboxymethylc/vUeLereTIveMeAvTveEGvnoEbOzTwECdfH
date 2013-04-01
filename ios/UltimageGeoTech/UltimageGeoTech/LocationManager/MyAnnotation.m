//
//  MyAnnotation.m
//  Map
//
//  Created by Palak Patel on 12/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize coordinate, title,currentPoint,img,curId,subtitle,race_detail_dictioanary;

-(void)dealloc 
{
	[title release];
    [subtitle release];
	[img release];
    [race_detail_dictioanary release];
	[super dealloc];
}

@end