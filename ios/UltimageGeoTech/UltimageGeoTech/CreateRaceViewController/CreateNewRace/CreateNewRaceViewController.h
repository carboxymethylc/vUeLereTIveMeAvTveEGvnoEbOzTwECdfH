//
//  CreateNewRaceViewController.h
//  UltimageGeoTech
//
//  Created by LD.Chirag on 2/5/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CreateNewRaceViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    AppDelegate*app_delegate;
    IBOutlet UITableView*question_list_tblView;
}

-(IBAction)button_clicked:(id)sender;

@end
