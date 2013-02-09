//
//  AddMultipleChoiceQuestionViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/5/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "AddMultipleChoiceQuestionViewController.h"

@interface AddMultipleChoiceQuestionViewController ()

@end

@implementation AddMultipleChoiceQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    accountScrollView.contentSize = CGSizeMake(320,400);
    
    multiQue_toolbar.hidden = TRUE;
    current_text_view_tag = 0;
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [app_delegate.current_question_dictionary removeAllObjects];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)correct_answer_pressed:(id)sender
{
    UIButton*tempButton = (UIButton*)sender;
    int tag = tempButton.tag-1000;
    
    
    switch (tag)
    {
        case 1:
        {
            [app_delegate.current_question_dictionary setObject:@"a" forKey:@"correct_answer"];
            break;
        }
        case 2:
        {
            [app_delegate.current_question_dictionary setObject:@"b" forKey:@"correct_answer"];
            break;
        }
        case 3:
        {
            [app_delegate.current_question_dictionary setObject:@"c" forKey:@"correct_answer"];
            break;
        }
        case 4:
        {
            [app_delegate.current_question_dictionary setObject:@"d" forKey:@"correct_answer"];
            break;
        }
                    
        default:
            break;
    }

    
    
    
    
}

-(IBAction)save_button_pressed:(id)sender
{
    
    //
    
    multiQue_toolbar.hidden = TRUE;
    [self.view endEditing:TRUE];
    [app_delegate.current_question_dictionary setObject:@"" forKey:@""];
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

    
    NSLog(@"\n app_delegate.current_question_dictionary = %@",app_delegate.current_question_dictionary);
    
    
}

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



@end
