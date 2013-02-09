//
//  AddMissingLetterQuestionViewController.h
//  UltimageGeoTech
//
//  Created by Chirag@Sunshine on 06/02/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AddMissingLetterQuestionViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UIScrollView*missing_character_scrollview;
    AppDelegate*app_delegate;
    
    IBOutlet UITextView*question_textView;//1001
    IBOutlet UITextView*answer_textView;//1002
    int current_text_view_tag;
    
    
    IBOutlet UIToolbar*missing_letter_que_toolbar;
    IBOutlet UITextField*number_of_letters_to_show_textField;
    
    
    
    
}

-(IBAction)save_button_pressed:(id)sender;


@end
