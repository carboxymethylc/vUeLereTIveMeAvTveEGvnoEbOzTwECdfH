//
//  AddMultipleChoiceQuestionViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/5/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "AddMultipleChoiceQuestionViewController.h"
#import "ChooseLocationViewController.h"
@interface AddMultipleChoiceQuestionViewController ()

@end

@implementation AddMultipleChoiceQuestionViewController

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
    
    accountScrollView.contentSize = CGSizeMake(320,400);
    
    multiQue_toolbar.hidden = TRUE;
    current_text_view_tag = 0;
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    if(app_delegate.is_in_question_editing_mode)
    {
       
        
        question_textView.text =  [app_delegate.current_question_dictionary objectForKey:@"question"];

        answer1_textView.text = [app_delegate.current_question_dictionary objectForKey:@"option_a"];
        answer2_textView.text = [app_delegate.current_question_dictionary objectForKey:@"option_b"];
        answer3_textView.text = [app_delegate.current_question_dictionary objectForKey:@"option_c"];
        answer4_textView.text = [app_delegate.current_question_dictionary objectForKey:@"option_d"];
        
        app_delegate.current_question_latitude = [[app_delegate.current_question_dictionary objectForKey:@"current_question_latitude"] floatValue];
        app_delegate.current_question_longitued = [[app_delegate.current_question_dictionary objectForKey:@"current_question_longitued"] floatValue];
        
        
        
    }
    
    
    /*
     city = test123;
     email = "test@gmail.com";
     "full_name" = test;
     "gps_rank" = 0;
     "race_completed" = 0;
     "race_created" = 0;
     "user_id" = 1;
     "user_name" = "test@gmail.com";
     
     */
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - didReceiveMemoryWarning

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - correct_answer_pressed

-(IBAction)correct_answer_pressed:(id)sender
{
    UIButton*tempButton = (UIButton*)sender;
    int tag = tempButton.tag-1000;
    
    
    switch (tag)
    {
        case 1:
        {
            [app_delegate.current_question_dictionary setObject:[NSNumber numberWithInt:1] forKey:@"correct_answer"];
            break;
        }
        case 2:
        {
            [app_delegate.current_question_dictionary setObject:[NSNumber numberWithInt:2]  forKey:@"correct_answer"];
            break;
        }
        case 3:
        {
            [app_delegate.current_question_dictionary setObject:[NSNumber numberWithInt:3]  forKey:@"correct_answer"];
            break;
        }
        case 4:
        {
            [app_delegate.current_question_dictionary setObject:[NSNumber numberWithInt:4]  forKey:@"correct_answer"];
            break;
        }
                    
        default:
            break;
    }

    
    
    
    
}

#pragma mark - save_button_pressed

-(IBAction)save_button_pressed:(id)sender
{
    
    //
    
    multiQue_toolbar.hidden = TRUE;
    [self.view endEditing:TRUE];
    
    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_latitude] forKey:@"current_question_latitude"];
    
    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_longitued] forKey:@"current_question_longitued"];
    
    [app_delegate.current_question_dictionary setObject:@"1" forKey:@"question_type"];
    
    switch (current_text_view_tag)
    {
        case 1:
        {
            
            
            [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
            break;
        }
        case 2:
        {
            [app_delegate.current_question_dictionary setObject:answer1_textView.text forKey:@"option_a"];
            break;
        }
        case 3:
        {
            [app_delegate.current_question_dictionary setObject:answer2_textView.text forKey:@"option_b"];
            break;
        }
        case 4:
        {
            [app_delegate.current_question_dictionary setObject:answer3_textView.text forKey:@"option_c"];
            break;
        }
        case 5:
        {
            [app_delegate.current_question_dictionary setObject:answer4_textView.text forKey:@"option_d"];
            break;
        }
            
        default:
            break;
    }

    if(app_delegate.is_in_question_editing_mode)
    {
        [app_delegate.current_race_question_array replaceObjectAtIndex:app_delegate.selected_question_index_for_edit withObject:app_delegate.current_question_dictionary];
    }
    else
    {
        
        [app_delegate.current_race_question_array addObject:app_delegate.current_question_dictionary];
    }

    
    
   
    NSLog(@"\n app_delegate.current_question_dictionary = %@",app_delegate.current_question_dictionary);
    [self.navigationController popViewControllerAnimated:TRUE];
    
}

#pragma mark - TextView methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    current_text_view_tag = textView.tag-2000;
    accountScrollView.contentSize = CGSizeMake(320,630);
    multiQue_toolbar.hidden = FALSE;
    return TRUE;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
    current_text_view_tag = textView.tag-2000;
    
    switch (current_text_view_tag)
    {
        case 1:
        {
            
            [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
            break;
        }
        case 2:
        {
             [app_delegate.current_question_dictionary setObject:answer1_textView.text forKey:@"option_a"];
            break;
        }
        case 3:
        {
            [app_delegate.current_question_dictionary setObject:answer2_textView.text forKey:@"option_b"];
            break;
        }
        case 4:
        {
            [app_delegate.current_question_dictionary setObject:answer3_textView.text forKey:@"option_c"];
            break;
        }
        case 5:
        {
            [app_delegate.current_question_dictionary setObject:answer4_textView.text forKey:@"option_d"];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - toolbar_doneButton_pressed

-(IBAction)toolbar_doneButton_pressed:(id)sender
{
    accountScrollView.contentSize = CGSizeMake(320,400);
    multiQue_toolbar.hidden = TRUE;
    [self.view endEditing:TRUE];
    
    switch (current_text_view_tag)
    {
        case 1:
        {
            
            
            [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
            break;
        }
        case 2:
        {
            [app_delegate.current_question_dictionary setObject:answer1_textView.text forKey:@"option_a"];
            break;
        }
        case 3:
        {
            [app_delegate.current_question_dictionary setObject:answer2_textView.text forKey:@"option_b"];
            break;
        }
        case 4:
        {
            [app_delegate.current_question_dictionary setObject:answer3_textView.text forKey:@"option_c"];
            break;
        }
        case 5:
        {
            [app_delegate.current_question_dictionary setObject:answer4_textView.text forKey:@"option_d"];
            break;
        }
            
        default:
            break;
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
