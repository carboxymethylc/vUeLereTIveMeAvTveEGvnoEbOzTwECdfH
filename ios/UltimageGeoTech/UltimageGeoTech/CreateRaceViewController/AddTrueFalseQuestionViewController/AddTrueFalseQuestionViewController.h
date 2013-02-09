//
//  AddTrueFalseQuestionViewController.h
//  UltimageGeoTech
//
//  Created by Chirag@Sunshine on 06/02/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AddTrueFalseQuestionViewController : UIViewController
{
    IBOutlet UIScrollView*true_false_question_scrollview;
    
    IBOutlet UITextView*question_textView;//1001
   
    IBOutlet UIToolbar*true_false_que_toolbar;
    
    IBOutlet UIButton*true_button;//2001
    IBOutlet UIButton*false_button;//2002
    
    
    AppDelegate*app_delegate;

}
-(IBAction)save_button_pressed:(id)sender;
-(IBAction)true_false_button_pressed:(id)sender;
@end
