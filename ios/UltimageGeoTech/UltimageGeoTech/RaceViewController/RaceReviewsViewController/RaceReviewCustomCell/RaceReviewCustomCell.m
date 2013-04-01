//
//  RaceReviewCustomCell.m
//  UltimageGeoTech
//
//  Created by LD.Chirag on 3/31/13.
//  Copyright (c) 2013 LD.Chirag. All rights reserved.
//

#import "RaceReviewCustomCell.h"

@implementation RaceReviewCustomCell
@synthesize cell_review_label;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    
    [cell_review_label release];
    [super dealloc];
}

@end
