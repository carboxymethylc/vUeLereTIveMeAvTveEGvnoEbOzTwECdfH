//
//  AddMultipleChoiceQuestionViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/5/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AddMultipleChoiceQuestionViewController : UIViewController<UITextViewDelegate>
{
    IBOutlet UIScrollView*accountScrollView;
    
    IBOutlet UITextView*question_textView;
    
    IBOutlet UITextView*answer1_textView;
    IBOutlet UITextView*answer2_textView;
    IBOutlet UITextView*answer3_textView;
    IBOutlet UITextView*answer4_textView;
    
    IBOutlet UIButton*answer_button_a;
    IBOutlet UIButton*answer_button_b;
    IBOutlet UIButton*answer_button_c;
    IBOutlet UIButton*answer_button_d;
    
    int current_answer;
    
    
    IBOutlet UIToolbar*multiQue_toolbar;
    int current_text_view_tag;
    
    AppDelegate*app_delegate;
    
    
    
}

-(IBAction)toolbar_doneButton_pressed:(id)sender;
-(IBAction)correct_answer_pressed:(id)sender;
-(IBAction)save_button_pressed:(id)sender;


@end
