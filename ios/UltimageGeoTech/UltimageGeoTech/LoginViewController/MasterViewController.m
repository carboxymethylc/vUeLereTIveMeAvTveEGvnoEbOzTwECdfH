//
//  MasterViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 1/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "MasterViewController.h"

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Login", @"Login");
    }
    return self;
}
							
- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
