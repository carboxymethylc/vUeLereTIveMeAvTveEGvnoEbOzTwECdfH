//
//  AddCheckInQuestionViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 3/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "AddCheckInQuestionViewController.h"
#import "ChooseLocationViewController.h"
@interface AddCheckInQuestionViewController ()

@end

@implementation AddCheckInQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        
        app_delegate.current_question_dictionary = [[NSMutableDictionary alloc] init];
        [app_delegate.current_question_dictionary removeAllObjects];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    checkin_que_toolbar.hidden = TRUE;
    
    if(app_delegate.is_in_question_editing_mode)
    {
        checkIn_question_textView.text = [app_delegate.current_question_dictionary objectForKey:@"question"];
        
    }

    
    
    // Do any additional setup after loading the view from its nib.
}


#pragma mark - edit_location_clicked
-(IBAction)edit_location_clicked:(id)sender
{
    ChooseLocationViewController*viewController = [[ChooseLocationViewController alloc] initWithNibName:@"ChooseLocationViewController" bundle:nil];
    
    if(app_delegate.is_in_question_editing_mode)
    {
        app_delegate.current_question_latitude =  [[app_delegate.current_question_dictionary objectForKey:@"current_question_latitude"] floatValue];
        app_delegate.current_question_longitued =  [[app_delegate.current_question_dictionary objectForKey:@"current_question_longitued"] floatValue];
    }
    
    
    
    [self.navigationController pushViewController:viewController animated:TRUE];
    [viewController release];
}

#pragma mark - textView Delegate methods..
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return TRUE;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return TRUE;
}
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    checkin_que_toolbar.hidden = FALSE;
    checkIn_question_textView.frame = CGRectMake(checkIn_question_textView.frame.origin.x, checkIn_question_textView.frame.origin.y,checkIn_question_textView.frame.size.width, 123.0f);
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    checkIn_question_textView.frame = CGRectMake(checkIn_question_textView.frame.origin.x, checkIn_question_textView.frame.origin.y,checkIn_question_textView.frame.size.width, 236.0f);
}


#pragma mark - save_button_pressed
-(IBAction)save_button_pressed:(id)sender
{
    checkIn_question_textView.hidden = TRUE;
    
    
    [app_delegate.current_question_dictionary setObject:checkIn_question_textView.text forKey:@"question"];
    [self.view endEditing:TRUE];
    
    
    
    
    
    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_latitude] forKey:@"current_question_latitude"];
    
    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_longitued] forKey:@"current_question_longitued"];
    
    
    [app_delegate.current_question_dictionary setObject:@"4" forKey:@"question_type"];
    
    
    NSLog(@"\n app_delegate.current_question_dictionary = %@",app_delegate.current_question_dictionary);
    
    
    if(app_delegate.is_in_question_editing_mode)
    {
        [app_delegate.current_race_question_array replaceObjectAtIndex:app_delegate.selected_question_index_for_edit withObject:app_delegate.current_question_dictionary];
    }
    else
    {
        [app_delegate.current_race_question_array addObject:app_delegate.current_question_dictionary];
    }
    checkin_que_toolbar.hidden = TRUE;
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

#pragma mark - toolbar_doneButton_pressed

-(IBAction)toolbar_doneButton_pressed:(id)sender
{
    [app_delegate.current_question_dictionary setObject:checkIn_question_textView.text forKey:@"question"];
    checkin_que_toolbar.hidden = TRUE;
    [self.view endEditing:TRUE];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
