//
//  MyAnnotation.m
//  Map
//
//  Created by Palak Patel on 12/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize coordinate, title,currentPoint,img,curId,subtitle;

-(void)dealloc 
{
	[title release];
    [subtitle release];
	[img release];
	[super dealloc];
}

@end