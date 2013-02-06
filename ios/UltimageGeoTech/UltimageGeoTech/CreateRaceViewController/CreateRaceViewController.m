//
//  CreateRaceViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "CreateRaceViewController.h"
#import "CreateNewRaceViewController.h"
@interface CreateRaceViewController ()

@end

@implementation CreateRaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = NSLocalizedString(@"Create Race", @"Create Race");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)create_race_button_pressed:(id)sender
{
    CreateNewRaceViewController*viewController = [[CreateNewRaceViewController alloc] initWithNibName:@"CreateNewRaceViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:TRUE];
    [viewController release];
}

@end
