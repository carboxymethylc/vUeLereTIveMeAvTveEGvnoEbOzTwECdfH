//
//  RaceReviewsViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 3/31/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RaceReviewCustomCell.h"
#import "AppDelegate.h"
@interface RaceReviewsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    IBOutlet UITableView*race_review_tableView;
    RaceReviewCustomCell*tblCell;
    UINib *cellNib;
    
    
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
    //NSMutableArray *responseDataArray;//May be needed
    
    IBOutlet UIActivityIndicatorView*process_activity_indicator;

    
    AppDelegate *app_delegate;
    
    
}

@property(nonatomic,retain)IBOutlet RaceReviewCustomCell*tblCell;
@property(nonatomic,retain)UINib *cellNib;


@end
