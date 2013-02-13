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

#import "AddMultipleChoiceQuestionViewController.h"
#import "AddTrueFalseQuestionViewController.h"
#import "AddMissingLetterQuestionViewController.h"

#import "SaveAndCreateRaceViewController.h"

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

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app_delegate.is_in_question_editing_mode = FALSE;
    app_delegate.current_question_latitude = app_delegate.current_latitude;
    app_delegate.current_question_longitued =app_delegate.current_longitued;
    
    [app_delegate.current_race_question_array removeAllObjects];
    
   // question_list_tblView.can
}

#pragma mark - viewWillAppear

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"\n app_delegate.current_question_latitude = %f",app_delegate.current_question_latitude);
    NSLog(@"\n app_delegate.current_question_longitued = %f",app_delegate.current_question_longitued);
    
    NSLog(@"\n app_delegate.current_race_question_array = %@",app_delegate.current_race_question_array);
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    app_delegate.is_in_question_editing_mode = FALSE;

    if([app_delegate.current_race_question_array count]==0)
    {
        question_list_tblView.hidden = TRUE;
        save_race_button.hidden = TRUE;
    }
    else
    {
        question_list_tblView.hidden = FALSE;
        save_race_button.hidden = FALSE;
        [question_list_tblView reloadData];

    }
    
    
}

#pragma mark - didReceiveMemoryWarning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - button_clicked

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

#pragma mark - Tableview methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return  [app_delegate.current_race_question_array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
	
	// Try to retrieve from the table view a now-unused cell with the given identifier.
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
	
	// If no cell is available, create a new one using the given identifier.
	if (cell == nil)
    {
		// Use the default cell style.
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier] autorelease];
	}
	
	// Set up the cell.
	
    
    
	cell.textLabel.text = [[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"question"];
	
	return cell;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    app_delegate.is_in_question_editing_mode = TRUE;
    app_delegate.selected_question_index_for_edit = indexPath.row;
    
    
    int question_type =  [[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"question_type"] intValue];
    
#import "AddMultipleChoiceQuestionViewController.h"
#import "AddTrueFalseQuestionViewController.h"
#import "AddMissingLetterQuestionViewController.h"
    
    
    
    switch (question_type)
    {
        case 1:
        {
            AddMultipleChoiceQuestionViewController*viewController = [[AddMultipleChoiceQuestionViewController alloc] initWithNibName:@"AddMultipleChoiceQuestionViewController" bundle:nil];
            
            
            
            
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"correct_answer"]
             forKey:@"correct_answer"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"current_question_latitude"]
             forKey:@"current_question_latitude"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"current_question_longitued"]
             forKey:@"current_question_longitued"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"option_a"]
             forKey:@"option_a"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"option_b"]
             forKey:@"option_b"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"option_c"]
             forKey:@"option_c"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"option_d"]
             forKey:@"option_d"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"question"]
             forKey:@"question"];
            
            
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
            
            
            break;
            
        }
        case 2:
        {
            
            AddTrueFalseQuestionViewController*viewController = [[AddTrueFalseQuestionViewController alloc] initWithNibName:@"AddTrueFalseQuestionViewController" bundle:nil];
            
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"question"]
             forKey:@"question"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"current_question_latitude"]
             forKey:@"current_question_latitude"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"current_question_longitued"]
             forKey:@"current_question_longitued"];

            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"answer"]
             forKey:@"answer"];
            
            /*
            app_delegate.current_question_dictionary = {
                answer = 1;
                "current_question_latitude" = "23.03828";
                "current_question_longitued" = "72.52428";
                question = test;
                "question_type" = 2;
            }
            */
            
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
            
            break;
        }
        case 3:
        {
            AddMissingLetterQuestionViewController*viewController = [[AddMissingLetterQuestionViewController alloc] initWithNibName:@"AddMissingLetterQuestionViewController" bundle:nil];
            
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"question"]
             forKey:@"question"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"current_question_latitude"]
             forKey:@"current_question_latitude"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"current_question_longitued"]
             forKey:@"current_question_longitued"];
            
            
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"answer"]
             forKey:@"answer"];
            
            [app_delegate.current_question_dictionary
             setObject:[[app_delegate.current_race_question_array objectAtIndex:indexPath.row] objectForKey:@"number_of_letters_to_show"]
             forKey:@"number_of_letters_to_show"];
            
            
            /*
            answer = qweu;
            "current_question_latitude" = "23.03847";
            "current_question_longitued" = "72.52427";
            "number_of_letters_to_show" = 2;
            question = "test-miss";
            "question_type" = "";
            */
            
            [self.navigationController pushViewController:viewController animated:YES];
            [viewController release];
            
            break;
        }
            
        default:
            break;
    }
    
    
    NSLog(@"\n indexPath.row = %d",indexPath.row);
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //add code here for when you hit delete
        [app_delegate.current_race_question_array removeObjectAtIndex:indexPath.row];
        [question_list_tblView reloadData];
        
    }
}

#pragma mark - save_race_button_pressed
-(IBAction)save_race_button_pressed:(id)sender
{
    SaveAndCreateRaceViewController*viewController = [[SaveAndCreateRaceViewController alloc] initWithNibName:@"SaveAndCreateRaceViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
