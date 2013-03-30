//
//  RaceViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "RaceViewController.h"
#import "MyAnnotation.h"
@interface RaceViewController ()

@end

@implementation RaceViewController
@synthesize search_filters;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = NSLocalizedString(@"Race", @"Race");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mapView.mapType = MKMapTypeStandard;
	mapView.showsUserLocation = YES;
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    
    filter_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [filter_button setTitle:@"Filter" forState:UIControlStateNormal];
    [filter_button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    filter_button.bounds = CGRectMake(0, 0, 49.0, 30.0);
    [filter_button addTarget:self action:@selector(filter_button_pressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[[UIBarButtonItem alloc] initWithCustomView:filter_button] autorelease];
    
    search_view.hidden = TRUE;
    
    /*
     geoCoder=[[MKReverseGeocoder alloc] initWithCoordinate:mapView.userLocation.location.coordinate];
     
     geoCoder.delegate=self;
     [geoCoder start];
     */
    
    
    
    filter_types = [[NSMutableArray alloc] initWithObjects:
                    @"All",
                    @"Race with Check In Questions",
                    @"Race with MCQ",
                    @"Race with Missing Letter Questions",
                    @"Race with true or false Questions",
                    @"Race with less than 5 Questions",
                    @"Race with 5 to 10 Questions",
                    @"Race with more than 10 Questions",
                    @"Race with 1 star",
                    @"Race with 2 star",
                    @"Race with 3 star",
                    @"Race with 4 star",
                    @"Race with 5 star",
                    @"Race with difficulty level 1",
                    @"Race with difficulty level 2",
                    @"Race with difficulty level 3",
                    @"Race with difficulty level 4",
                    @"Race with difficulty level 5",
                    nil];
    
	checked_filters = [[NSMutableDictionary alloc] init];
    [checked_filters setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:0]];
    
    tableView_cell_array = [[NSMutableArray alloc] init];
    
    search_filters= [[NSMutableArray alloc] init];
    
    all_questions_index = [[NSMutableArray alloc] init];
    
    final_question_array = [[NSMutableArray alloc] init];
    
    initial_question_array = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    
    
    
    CLLocationCoordinate2D location2 = mapView.userLocation.coordinate;
	location2.latitude=app_delegate.current_latitude;
	location2.longitude=app_delegate.current_longitued;
    
    
    /*
     region.span=span;
     region.center=location2;
     */
    
    region.center.latitude = app_delegate.current_question_latitude;
    region.center.longitude = app_delegate.current_question_longitued;
    
    
    
    
    region.span.latitudeDelta = 0.112872;
    region.span.longitudeDelta = 0.109863;
    
    
    
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
    
    NSLog(@"\n  user Info. dic = %@",app_delegate.user_information_dictionary);
    
    
    
    current_request_type = 1;
    
    requestObjects = [NSArray arrayWithObjects:
                      @"get_near_by_races",
                      [NSNumber numberWithFloat:app_delegate.current_latitude],
                      [NSNumber numberWithFloat:app_delegate.current_longitued],
                      [app_delegate.user_information_dictionary objectForKey:@"user_id"],
                      nil];
    
    requestkeys = [NSArray arrayWithObjects:
                   @"action",
                   @"user_latitude",
                   @"user_longitude",
                   @"user_id",
                   nil];
    
    
    
    
    
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
    
    
    
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSLog(@"\n response we get = %@",response);
         returnData = data;
         NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
         NSLog(@"\n returnString == %@",returnString);
         json = [[SBJSON new] autorelease];
         
         
         responseDataArray = [json objectWithString:returnString error:&error];
         [responseDataArray retain];
         
         
         
         initial_question_array = [NSMutableArray arrayWithArray:responseDataArray];
         [initial_question_array retain];
         NSLog(@"\n initial_question_array = %@",initial_question_array);
         
         
         [self performSelectorOnMainThread:@selector(enable_user_interaction) withObject:nil waitUntilDone:TRUE];
         
         
         
     }];
    
    [queue release];
    
    
    
    [super viewWillAppear:animated];
}

#pragma mark - enable_user_interaction

-(void)enable_user_interaction
{
    [process_activity_indicator stopAnimating];
    
    process_activity_indicator.hidden = TRUE;
    
    //race_latitude
    //race_longitude
    
    
    
    
    switch (current_request_type)
    {
        case 1:
        {
            for(int i=0;i<[responseDataArray count];i++)
            {
                MyAnnotation *annotation =  [[MyAnnotation alloc] init];
                
                
                
                annotation.coordinate = CLLocationCoordinate2DMake([[[responseDataArray objectAtIndex:i] objectForKey:@"race_latitude"] floatValue],[[[responseDataArray objectAtIndex:i] objectForKey:@"race_longitude"] floatValue]);
                annotation.currentPoint = 1;
                
                
                
                
                
                annotation.title= [[responseDataArray objectAtIndex:i] objectForKey:@"race_name"];
                annotation.subtitle = [[responseDataArray objectAtIndex:i] objectForKey:@"race_info"];
                annotation.curId= [[[responseDataArray objectAtIndex:i] objectForKey:@"id"] intValue];
                [mapView addAnnotation:annotation];
                [annotation release];
                
            }
            break;
        }
        default:
        {
            break;
        }
            
    }
    [self.view setUserInteractionEnabled:TRUE];
    
}



#pragma mark - tableview methods.

#pragma mark - numberOfRowsInSection

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  [filter_types count];
    
}

#pragma mark - cellForRowAtIndexPath

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	//if (cell == nil)
    {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
    
    
    int checked = 0;
    
    if([checked_filters objectForKey:[NSNumber numberWithInt:indexPath.row]]!=nil)
    {
        checked = [[checked_filters objectForKey:[NSNumber numberWithInt:indexPath.row]] intValue];
    }
    
    UIImage *image;
    if(checked==1)
    {
        image =[UIImage imageNamed:@"checked"];
    }
    else
    {
        image =[UIImage imageNamed:@"unchecked"];
    }
	
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
	button.frame = frame;	// match the button's size with the image size
    
	[button setBackgroundImage:image forState:UIControlStateNormal];
	
	[button addTarget:self action:@selector(checkButtonTapped:event:) forControlEvents:UIControlEventTouchUpInside];
    
	cell.backgroundColor = [UIColor clearColor];
	cell.accessoryView = button;
    cell.textLabel.text = [filter_types objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    [tableView_cell_array addObject:cell];
    
    return cell;
    
}

#pragma mark - checkButtonTapped

- (void)checkButtonTapped:(id)sender event:(id)event
{
	NSSet *touches = [event allTouches];
	UITouch *touch = [touches anyObject];
	CGPoint currentTouchPosition = [touch locationInView:search_filter_tableView];
    
	NSIndexPath *indexPath = [search_filter_tableView indexPathForRowAtPoint: currentTouchPosition];
	if (indexPath != nil)
	{
		[self tableView:search_filter_tableView accessoryButtonTappedForRowWithIndexPath: indexPath];
	}
}

#pragma mark - accessoryButtonTappedForRowWithIndexPath

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	
    
    
    //UITableViewCell *cell = [tableView_cell_array objectAtIndex:indexPath.row];
	
	int checked;
	
    NSLog(@"\n checked_filters before= %@",checked_filters);
    
    
    
    if(indexPath.row !=0)
    {
        if([checked_filters objectForKey:[NSNumber numberWithInt:0]]!=nil)
        {
            if([[checked_filters objectForKey:[NSNumber numberWithInt:0]] intValue]==1)
            {
                return;
            }
        }
        
    }
    
    
    
    if([checked_filters objectForKey:[NSNumber numberWithInt:indexPath.row]]!=nil)
    {
        checked = [[checked_filters objectForKey:[NSNumber numberWithInt:indexPath.row]] intValue];
        
        if(checked==1)
        {
            
            checked = 0;
            [checked_filters setObject:[NSNumber numberWithInt:0] forKey:[NSNumber numberWithInt:indexPath.row]];
            
        }
        else
        {
            
            checked = 1;
            if(indexPath.row==0)
            {
                [checked_filters removeAllObjects];
            }
            
            [checked_filters setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:indexPath.row]];
        }
        
    }
    else
    {
        checked = 1;
        [checked_filters setObject:[NSNumber numberWithInt:1] forKey:[NSNumber numberWithInt:indexPath.row]];
    }
    
    
    [search_filter_tableView reloadData];
    
    
    
}


#pragma mark -

#pragma mark - filter_button_pressed

-(void)filter_button_pressed
{
    
    if (search_view.hidden)
    {
        search_view.hidden = FALSE;
        [filter_button setTitle:@"Cancel" forState:UIControlStateNormal];
        
    }
    else
    {
        search_view.hidden = TRUE;
        [filter_button setTitle:@"Filte" forState:UIControlStateNormal];
    }
}

#pragma mark - search_done_button_pressed

-(IBAction)search_done_button_pressed:(id)sender
{
    
    NSLog(@"\n checked_filters %@",checked_filters);
    

    [responseDataArray removeAllObjects];

    for (int i = 0;i<[initial_question_array count]; i++)
    {
        [responseDataArray addObject:[initial_question_array objectAtIndex:i]];
    }
    
    
    NSLog(@"\n responseDataArray = %@",initial_question_array);
    
    
    [final_question_array removeAllObjects];
    [search_filters removeAllObjects];
    
    NSLog(@"\n responseDataArray = %@",responseDataArray);
    
    for(int i=0;i<[[checked_filters allKeys] count];i++)
    {
        
        
        if([[checked_filters objectForKey:[[checked_filters allKeys] objectAtIndex:i]] intValue]==1)
        {
            
            
            
            [search_filters addObject:[filter_types objectAtIndex:[[[checked_filters allKeys] objectAtIndex:i] intValue]]];
            
            
        }
    }
    
    NSLog(@"\n search_filters %@",search_filters);
    
    
    
    if([search_filters containsObject:@"Race with Check In Questions"])
    {
        
        [all_questions_index removeAllObjects];
        
        for(int i=0;i<[responseDataArray count];i++)
        {
            
            NSMutableArray*temp_question_array =  [[responseDataArray objectAtIndex:i] objectForKey:@"race_questions"];
            
            for(int j=0;j<[temp_question_array count];j++)
            {
                
                if([[[temp_question_array objectAtIndex:j] objectForKey:@"question_type"] intValue]==4)
                {
                    
                    [final_question_array addObject:[responseDataArray objectAtIndex:i]];
                    [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
                    break;
                    
                }
                
                
            }
        }
        
        
        
        
        for(int i=0;i<[all_questions_index count];i++)
        {
            [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
        }
        
        
        NSLog(@"\n responseDataArray after = %@",responseDataArray);
        
        
        
        
        
    }
    
    
    if([search_filters containsObject:@"Race with MCQ"])
    {
        
        [all_questions_index removeAllObjects];
        
        for(int i=0;i<[responseDataArray count];i++)
        {
            
            NSMutableArray*temp_question_array =  [[responseDataArray objectAtIndex:i] objectForKey:@"race_questions"];
            
            for(int j=0;j<[temp_question_array count];j++)
            {
                
                if([[[temp_question_array objectAtIndex:j] objectForKey:@"question_type"] intValue]==1)
                {
                    
                    [final_question_array addObject:[responseDataArray objectAtIndex:i]];
                    [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
                    break;
                    
                }
                
                
            }
        }
        for(int i=0;i<[all_questions_index count];i++)
        {
            [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
        }
        
        
        NSLog(@"\n mCQ responseDataArray after = %@",responseDataArray);
        
    }
    
    
    
    //Race with Missing Letter Questions
    
    if([search_filters containsObject:@"Race with Missing Letter Questions"])
    {
        
        [all_questions_index removeAllObjects];
        
        for(int i=0;i<[responseDataArray count];i++)
        {
            
            NSMutableArray*temp_question_array =  [[responseDataArray objectAtIndex:i] objectForKey:@"race_questions"];
            
            for(int j=0;j<[temp_question_array count];j++)
            {
                
                if([[[temp_question_array objectAtIndex:j] objectForKey:@"question_type"] intValue]==3)
                {
                    
                    [final_question_array addObject:[responseDataArray objectAtIndex:i]];
                    [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
                    break;
                    
                }
                
                
            }
        }
        for(int i=0;i<[all_questions_index count];i++)
        {
            [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
        }
        
        
        
    }
    
    
    
    //Race with true or false Questions
    
    if([search_filters containsObject:@"Race with true or false Questions"])
    {
        
        [all_questions_index removeAllObjects];
        
        for(int i=0;i<[responseDataArray count];i++)
        {
            
            NSMutableArray*temp_question_array =  [[responseDataArray objectAtIndex:i] objectForKey:@"race_questions"];
            
            for(int j=0;j<[temp_question_array count];j++)
            {
                
                if([[[temp_question_array objectAtIndex:j] objectForKey:@"question_type"] intValue]==2)
                {
                    
                    [final_question_array addObject:[responseDataArray objectAtIndex:i]];
                    [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
                    break;
                    
                }
                
                
            }
        }
        for(int i=0;i<[all_questions_index count];i++)
        {
            [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
        }
    
    
    
    
}

//Race with less than 5 Questions

if([search_filters containsObject:@"Race with less than 5 Questions"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        NSMutableArray*temp_question_array =  [[responseDataArray objectAtIndex:i] objectForKey:@"race_questions"];
        
        
        if([temp_question_array count]<5)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
    
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    

}





//Race with  5 - 10  Questions

if([search_filters containsObject:@"Race with 5 to 10 Questions"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        NSMutableArray*temp_question_array =  [[responseDataArray objectAtIndex:i] objectForKey:@"race_questions"];
        
        
        if([temp_question_array count]>=5 && [temp_question_array count]<=10)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with  more than 10  Questions

if([search_filters containsObject:@"Race with more than 10 Questions"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        NSMutableArray*temp_question_array =  [[responseDataArray objectAtIndex:i] objectForKey:@"race_questions"];
        
        
        if([temp_question_array count]>10)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with 1 star

if([search_filters containsObject:@"Race with 1 star"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_popularity =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_popularity"] intValue];
        
        
        if(race_popularity == 1)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with 2 star

if([search_filters containsObject:@"Race with 2 star"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_popularity =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_popularity"] intValue];
        
        
        if(race_popularity == 2)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with 3 star

if([search_filters containsObject:@"Race with 3 star"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_popularity =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_popularity"] intValue];
        
        
        if(race_popularity == 3)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}

//Race with 4 star

if([search_filters containsObject:@"Race with 4 star"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_popularity =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_popularity"] intValue];
        
        
        if(race_popularity == 4)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with 5 star

if([search_filters containsObject:@"Race with 5 star"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_popularity =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_popularity"] intValue];
        
        
        if(race_popularity == 5)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with difficulty level 1

if([search_filters containsObject:@"Race with difficulty level 1"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_difficulty =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_difficulty"] intValue];
        
        
        if(race_difficulty == 1)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}


//Race with difficulty level 2

if([search_filters containsObject:@"Race with difficulty level 2"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_difficulty =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_difficulty"] intValue];
        
        
        if(race_difficulty == 2)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with difficulty level 3

if([search_filters containsObject:@"Race with difficulty level 3"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_difficulty =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_difficulty"] intValue];
        
        
        if(race_difficulty == 3)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}



//Race with difficulty level 4

if([search_filters containsObject:@"Race with difficulty level 4"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_difficulty =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_difficulty"] intValue];
        
        
        if(race_difficulty == 4)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}





//Race with difficulty level 5

if([search_filters containsObject:@"Race with difficulty level 5"])
{
    
    [all_questions_index removeAllObjects];
    
    for(int i=0;i<[responseDataArray count];i++)
    {
        
        int race_difficulty =  [[[responseDataArray objectAtIndex:i] objectForKey:@"race_difficulty"] intValue];
        
        
        if(race_difficulty == 5)
        {
            
            [final_question_array addObject:[responseDataArray objectAtIndex:i]];
            [all_questions_index addObject:[responseDataArray objectAtIndex:i]];
            
        }
        
    }
    
    for(int i=0;i<[all_questions_index count];i++)
    {
        [responseDataArray removeObject:[all_questions_index objectAtIndex:i]];
    }
    
    
}






NSLog(@"\n  final_question_array  = %@",final_question_array);









}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
