//
//  AddTrueFalseQuestionViewController.m
//  UltimageGeoTech
//
//  Created by Chirag@Sunshine on 06/02/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "AddTrueFalseQuestionViewController.h"
#import "ChooseLocationViewController.h"
@interface AddTrueFalseQuestionViewController ()

@end

@implementation AddTrueFalseQuestionViewController

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
    // Do any additional setup after loading the view from its nib.
    
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;

    
    if(app_delegate.is_in_question_editing_mode)
    {
        question_textView.text = [app_delegate.current_question_dictionary objectForKey:@"question"];
        NSLog(@"\n correct answer is = %@",[app_delegate.current_question_dictionary objectForKey:@"answer"]);
        
    }
    
    true_false_que_toolbar.hidden = TRUE;
    true_false_question_scrollview.contentSize = CGSizeMake(320,400);

    
}


#pragma mark - didReceiveMemoryWarning
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - textView methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    true_false_que_toolbar.hidden = FALSE;
    true_false_question_scrollview.contentSize = CGSizeMake(320,630);
    return TRUE;
}


- (void)textViewDidEndEditing:(UITextView *)textView
{
    [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
}


#pragma mark - save_button_pressed
-(IBAction)save_button_pressed:(id)sender
{
    true_false_que_toolbar.hidden = TRUE;
    true_false_question_scrollview.contentSize = CGSizeMake(320,400);
    [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
    [self.view endEditing:TRUE];
    
    
    
   
    
    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_latitude] forKey:@"current_question_latitude"];
    
    [app_delegate.current_question_dictionary setObject:[NSNumber numberWithFloat:app_delegate.current_question_longitued] forKey:@"current_question_longitued"];
    
    
    [app_delegate.current_question_dictionary setObject:@"2" forKey:@"question_type"];

    
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

#pragma mark - true_false_button_pressed
-(IBAction)true_false_button_pressed:(id)sender
{
    
    UIButton*tempButton = (UIButton*)sender;
    switch (tempButton.tag)
    {
        case 2001:
        {
            
            [app_delegate.current_question_dictionary setObject:@"1" forKey:@"answer"];
            break;
            
        }
        case 2002:
        {
            [app_delegate.current_question_dictionary setObject:@"0" forKey:@"answer"];
            break;
        }
            
            
            
        default:
        {
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

#pragma mark - toolbar_doneButton_pressed

-(IBAction)toolbar_doneButton_pressed:(id)sender
{
    [app_delegate.current_question_dictionary setObject:question_textView.text forKey:@"question"];
    true_false_que_toolbar.hidden = TRUE;
    [self.view endEditing:TRUE];
    true_false_question_scrollview.contentSize = CGSizeMake(320,400);
}


#pragma mark - dealloc

-(void)dealloc
{
    [super dealloc];
    [app_delegate.current_question_dictionary release];
}



@end
