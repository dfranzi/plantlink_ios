//
//  PLScheduleCell.m
//  PlantLink
//
//  Created by Robert Maciej Pieta on 1/25/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleCell.h"

@implementation PLScheduleCell

/**
 * Adjusts labels to schedule cells extending from the notification cell class
 */
-(void)addLabels {
    [super addLabels];
    
    [nameLabel setFrame:CGRectMake(127, 5, 150, 50)];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20.0]];
    
    [dateLabel setFrame:CGRectMake(11, 33, 91, 21)];
    [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
    
    [dayLabel setFrame:CGRectMake(11, 7, 91, 31)];
    [dayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0]];
    
    [separatorView setFrame:CGRectMake(110, 5, 1, 50)];
    [separatorView setBackgroundColor:[UIColor lightGrayColor]];
    
    [self addSubview:separatorView];
}

#pragma mark -
#pragma mark Set Methods

/*
 * Sets the standard colors for the schedule cell so it can be reset
 */
-(void)setStandardColors {
    [background setBackgroundColor:Color_PlantLinkBlue];
    [backdrop setBackgroundColor:Color_PlantLinkBlue_Dark];
    
    [nameLabel setBackgroundColor:Color_PlantLinkBlue];
    [dayLabel setBackgroundColor:Color_PlantLinkBlue];
    [dateLabel setBackgroundColor:Color_PlantLinkBlue];
    
    [nameLabel setTextColor:[UIColor whiteColor]];
    [dayLabel setTextColor:[UIColor whiteColor]];
    [dateLabel setTextColor:[UIColor whiteColor]];
    [separatorView setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the size for the cell
 */
+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(297, 60);
}

@end
