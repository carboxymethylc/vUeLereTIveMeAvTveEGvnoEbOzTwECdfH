//
//  RaceReviewsViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 3/31/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "RaceReviewsViewController.h"

@interface RaceReviewsViewController ()

@end

@implementation RaceReviewsViewController

@synthesize tblCell,cellNib;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = @"Reviews";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.cellNib = [UINib nibWithNibName:@"RaceReviewCustomCell" bundle:nil];
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    requestObjects = [NSArray arrayWithObjects:
                      @"get_race_reviews",
                      [app_delegate.app_del_current_race_dictionary objectForKey:@"id"],
                      nil];
    
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
                   @"race_id",
                   nil];
    
    
    NSLog(@"\n requestObjects = %@",requestObjects);
    
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
    
    
    
    process_activity_indicator.hidden = FALSE;
    [process_activity_indicator startAnimating];
    [self.view bringSubviewToFront:process_activity_indicator];
    [self.view endEditing:TRUE];
    [self.view setUserInteractionEnabled:FALSE];
    
    
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSLog(@"\n response we get = %@",response);
         returnData = data;
     }];
    
    [queue release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    RaceReviewCustomCell *cell = (RaceReviewCustomCell *)[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil)
    {
        [self.cellNib instantiateWithOwner:self options:nil];
		cell = tblCell;
		self.tblCell = nil;
        
    }
	
	// Set up the cell.
    cell.cell_review_label.text = @"this is sample text.which will grow in size,but max upto  fjlds fj slfjdsljd fl j ldjf dlsjfdslfj";
	
	return cell;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}





@end
