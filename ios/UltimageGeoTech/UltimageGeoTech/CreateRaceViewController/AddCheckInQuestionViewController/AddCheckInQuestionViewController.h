//
//  AddCheckInQuestionViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 3/21/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface AddCheckInQuestionViewController : UIViewController<UITextViewDelegate>
{
     AppDelegate*app_delegate;
    
    IBOutlet UITextView*checkIn_question_textView;
    IBOutlet UIToolbar*checkin_que_toolbar;
    
}
-(IBAction)edit_location_clicked:(id)sender;
-(IBAction)save_button_pressed:(id)sender;
@end
