//
//  SaveAndCreateRaceViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/13/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "SaveAndCreateRaceViewController.h"

@interface SaveAndCreateRaceViewController ()

@end

@implementation SaveAndCreateRaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    race_extra_detail_decitionary = [[NSMutableDictionary alloc] init];
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - create_race_button_clicked

-(IBAction)create_race_button_clicked:(id)sender
{
    
    switch (current_textfield_textview_tag)
    {
        case 1001:
        {
            
            
            [race_extra_detail_decitionary setObject:race_name_text_field.text forKey:@"race_name"];
            break;
        }
        case 1002:
        {
            [race_extra_detail_decitionary setObject:race_detail_textView.text forKey:@"race_detail"];
            break;
        }
        case 1003:
        {
            [race_extra_detail_decitionary setObject:show_number_of_question_text_field.text forKey:@"number_of_question"];
            break;
        }
        default:
        {
            break;
        }
            
    }
    
    
    
    
    
    [race_extra_detail_decitionary setObject:[NSNumber numberWithFloat:app_delegate.current_latitude] forKey:@""];
    [race_extra_detail_decitionary setObject:[NSNumber numberWithFloat:app_delegate.current_longitued] forKey:@""];
    
    
    
    NSLog(@"\n race_extra_detail_decitionary = %@",race_extra_detail_decitionary);
    NSLog(@"\n app_delegate = %@",app_delegate.current_race_question_array);
}

#pragma mark - share_race_button_clicked
-(IBAction)share_race_button_clicked:(id)sender
{
    
}


#pragma mark - TextField methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return TRUE;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    current_textfield_textview_tag = textField.tag;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return TRUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (current_textfield_textview_tag)
    {
        case 1001:
        {
            [race_extra_detail_decitionary setObject:textField.text forKey:@"race_name"];
             break;
        }
            case 1003:
        {
            [race_extra_detail_decitionary setObject:textField.text forKey:@"number_of_question"];
             break;
        }
        default:
        {
            break;
        }
    
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return TRUE;
}


#pragma mark - TextView methods
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
    current_textfield_textview_tag = textView.tag;
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
     [race_extra_detail_decitionary setObject:textView.text forKey:@"race_detail"];
}


#pragma mark - dealloc
-(void)dealloc
{
    [race_extra_detail_decitionary release];
    [super dealloc];
}

@end
