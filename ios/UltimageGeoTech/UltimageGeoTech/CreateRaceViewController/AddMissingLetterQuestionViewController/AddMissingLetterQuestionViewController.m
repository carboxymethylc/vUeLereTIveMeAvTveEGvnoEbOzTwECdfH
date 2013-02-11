//
//  AddMissingLetterQuestionViewController.m
//  UltimageGeoTech
//
//  Created by Chirag@Sunshine on 06/02/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "AddMissingLetterQuestionViewController.h"
#import "ChooseLocationViewController.h"
@interface AddMissingLetterQuestionViewController ()

@end

@implementation AddMissingLetterQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        app_delegate.current_question_dictionary = [[NSMutableDictionary alloc] init];
        [app_delegate.current_question_dictionary removeAllObjects];
        
    }
    return self;
}

#pragma mark - viewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
                            
    
    missing_letter_que_toolbar.hidden = TRUE;
    
     current_text_view_tag = 0;
     missing_character_scrollview.contentSize = CGSizeMake(320,400);
     NSLog(@"\n app_delegate.current_question_dictionary = %@",app_delegate.current_question_dictionary);

    if(app_delegate.is_in_question_editing_mode)
    {
        question_textView.text = [app_delegate.current_question_dictionary  objectForKey:@"question"];
        answer_textView.text =[app_delegate.current_question_dictionary  objectForKey:@"answer"];
        number_of_letters_to_show_textField.text = [app_delegate.current_question_dictionary  objectForKey:@"number_of_letters_to_show"];
    }
    
    
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - didReceiveMemoryWarning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - save_button_pressed

-(IBAction)save_button_pressed:(id)sender
{
    missing_character_scrollview.contentSize = CGSizeMake(320,400);
    missing_letter_que_toolbar.hidden = TRUE;
    [self.view endEditing:TRUE];
    
    [app_delegate.current_question_dictionary setObject:@"3" forKey:@"question_type"];
    
    
    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_latitude] forKey:@"current_question_latitude"];

    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_longitued] forKey:@"current_question_longitued"];

    
   
    
    [app_delegate.current_question_dictionary setObject:number_of_letters_to_show_textField.text forKey:@"number_of_letters_to_show"];
    switch (current_text_view_tag)
    {
        case 1:
        {
            [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
            break;
        }
        case 2:
        {
            [app_delegate.current_question_dictionary setObject:answer_textView.text forKey:@"answer"];
            break;
        }
    }
    NSLog(@"\n app_delegate.current_question_dictionary = %@",app_delegate.current_question_dictionary);
    
    
    
    if(app_delegate.is_in_question_editing_mode)
    {
        [app_delegate.current_race_question_array replaceObjectAtIndex:app_delegate.selected_question_index_for_edit withObject:app_delegate.current_question_dictionary];
    }
    else
    {
        
        [app_delegate.current_race_question_array addObject:app_delegate.current_question_dictionary];
    }
    

    
    
    [self.navigationController popViewControllerAnimated:TRUE];
    
}


#pragma mark - TextField delegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
     missing_letter_que_toolbar.hidden = FALSE;
    return TRUE;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    missing_character_scrollview.contentSize = CGSizeMake(320,630);
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [app_delegate.current_question_dictionary setObject:number_of_letters_to_show_textField.text forKey:@"number_of_letters_to_show"];
    return TRUE;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    missing_character_scrollview.contentSize = CGSizeMake(320,400);
    [app_delegate.current_question_dictionary setObject:number_of_letters_to_show_textField.text forKey:@"number_of_letters_to_show"];
    [textField resignFirstResponder];
    return TRUE;
}


#pragma mark - TextView delegate methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
         missing_letter_que_toolbar.hidden = FALSE;
    missing_character_scrollview.contentSize = CGSizeMake(320,630);
    current_text_view_tag = textView.tag-1000;
    return TRUE;
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    current_text_view_tag = textView.tag-1000;
    
    switch (current_text_view_tag)
    {
        case 1:
        {
            [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
            break;
        }
        case 2:
        {
            [app_delegate.current_question_dictionary setObject:answer_textView.text forKey:@"answer"];
            break;
        }
    }

    
}

#pragma mark - toolbar_doneButton_pressed

-(IBAction)toolbar_doneButton_pressed:(id)sender
{
    missing_letter_que_toolbar.hidden = TRUE;
    [self.view endEditing:TRUE];
    
    missing_character_scrollview.contentSize = CGSizeMake(320,400);
    
    [app_delegate.current_question_dictionary setObject:number_of_letters_to_show_textField.text forKey:@"number_of_letters_to_show"];
    switch (current_text_view_tag)
    {
        case 1:
        {
            [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
            break;
        }
        case 2:
        {
            [app_delegate.current_question_dictionary setObject:answer_textView.text forKey:@"answer"];
            break;
        }
    }
    
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

#pragma mark - dealloc

-(void)dealloc
{
    [super dealloc];
    [app_delegate.current_question_dictionary release];
}



@end
