//
//  CreateNewRaceViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/5/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "CreateNewRaceViewController.h"


#import "AddMultipleChoiceQuestionViewController.h"
#import "AddMissingLetterQuestionViewController.h"
#import "AddTrueFalseQuestionViewController.h"
#import "ChooseLocationViewController.h"

@interface CreateNewRaceViewController ()

@end

@implementation CreateNewRaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    app_delegate.current_question_latitude = app_delegate.current_latitude;
    app_delegate.current_question_longitued =app_delegate.current_longitued;
    
    [app_delegate.current_race_question_array removeAllObjects];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"\n app_delegate.current_question_latitude = %f",app_delegate.current_question_latitude);
    NSLog(@"\n app_delegate.current_question_longitued = %f",app_delegate.current_question_longitued);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)button_clicked:(id)sender
{
    UIButton*temp_button  = (UIButton*)sender;
    switch (temp_button.tag)
    {
        case 1001:
        {
            
            AddMultipleChoiceQuestionViewController*viewController = [[AddMultipleChoiceQuestionViewController alloc] initWithNibName:@"AddMultipleChoiceQuestionViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:TRUE];
            [viewController release];
            
            break;
            
        }
        case 1002:
        {
            AddTrueFalseQuestionViewController*viewController = [[AddTrueFalseQuestionViewController alloc] initWithNibName:@"AddTrueFalseQuestionViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:TRUE];
            [viewController release];
            
            break;
        }
        case 1003:
        {
            
            AddMissingLetterQuestionViewController*viewController = [[AddMissingLetterQuestionViewController alloc] initWithNibName:@"AddMissingLetterQuestionViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:TRUE];
            [viewController release];
            break;
            
        }
        case 1004:
        {
            ChooseLocationViewController*viewController = [[ChooseLocationViewController alloc] initWithNibName:@"ChooseLocationViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:TRUE];
            [viewController release];
            
            break;
        }
            
        default:
        {
            break;
        }
    
    }
    
    
}

@end
