//
//  SaveAndCreateRaceViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/13/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SaveAndCreateRaceViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>
{
    IBOutlet UITextField* race_name_text_field;
    IBOutlet UITextField* show_number_of_question_text_field;
    
    IBOutlet UITextView*race_detail_textView;
    
}

-(IBAction)create_race_button_clicked:(id)sender;
-(IBAction)share_race_button_clicked:(id)sender;

@end
