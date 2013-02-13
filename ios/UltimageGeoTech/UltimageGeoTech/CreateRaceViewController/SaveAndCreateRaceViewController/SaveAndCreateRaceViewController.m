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
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return TRUE;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
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
    
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}



@end
