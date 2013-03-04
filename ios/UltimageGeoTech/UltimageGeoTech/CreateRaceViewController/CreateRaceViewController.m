//
//  CreateRaceViewController.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/2/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "CreateRaceViewController.h"
#import "CreateNewRaceViewController.h"
@interface CreateRaceViewController ()

@end

@implementation CreateRaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.title = NSLocalizedString(@"Create Race", @"Create Race");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    app_delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
   NSString* videoHTML = [NSString stringWithFormat:@"\
                 <html>\
                 <head>\
                 <style type=\"text/css\">\
                 iframe {position:absolute; top:50%%; margin-top:-130px;}\
                 body {background-color:#000; margin:0;}\
                 </style>\
                 </head>\
                 <body>\
                 <iframe width=\"100%%\" height=\"240px\" src=\"%@\" frameborder=\"0\" allowfullscreen></iframe>\
                 </body>\
                 </html>",@"http://www.youtube.com/embed/-owm1Ift7Ig"];
    
    [youTube_video_webView loadHTMLString:videoHTML baseURL:nil];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)create_race_button_pressed:(id)sender
{
    [app_delegate.current_race_question_array removeAllObjects];
    CreateNewRaceViewController*viewController = [[CreateNewRaceViewController alloc] initWithNibName:@"CreateNewRaceViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:TRUE];
    [viewController release];
}

@end
