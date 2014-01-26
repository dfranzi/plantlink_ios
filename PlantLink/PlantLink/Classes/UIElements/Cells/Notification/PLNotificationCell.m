//
//  PLNotificationCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationCell.h"

#import <QuartzCore/QuartzCore.h>
#import "PLNotificationModel.h"
#import "PLPlantModel.h"

@implementation PLNotificationCell

/**
 * Initializes the cell with the card like 3D appearnace, adds the necessary labels and sets initial parameters
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        CGSize size = [[self class] sizeForContent:@{}];
        
        background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-2)];
        [background setBackgroundColor:[UIColor whiteColor]];
        [background.layer setCornerRadius:3.0];
        [background setClipsToBounds:YES];
        [self.contentView insertSubview:background atIndex:0];
        
        backdrop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height+1)];
        [backdrop setBackgroundColor:Color_CellBorder];
        [backdrop.layer setCornerRadius:3.0];
        [backdrop setClipsToBounds:YES];
        [self.contentView insertSubview:backdrop belowSubview:background];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.contentView.layer setBorderColor:Color_CellBorder.CGColor];
        [self setClipsToBounds:NO];
        [self.layer setCornerRadius:3.0];
        [self addLabels];
    }
    return self;
}

/**
 * Initializes the required labels for the cell programatically
 */
-(void)addLabels {
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 10, 150, 65)];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:23.0]];
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setAdjustsFontSizeToFitWidth:YES];
    [nameLabel setMinimumScaleFactor:0.8];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setNumberOfLines:0];
    [self addSubview:nameLabel];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 49, 91, 21)];
    [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0]];
    [dateLabel setTextColor:[UIColor blackColor]];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    [dateLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:dateLabel];
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 14, 91, 34)];
    [dayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]];
    [dayLabel setTextColor:[UIColor blackColor]];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    [dayLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:dayLabel];
    
    separatorView = [[UIView alloc] initWithFrame:CGRectMake(110, 14, 1, 57)];
    [separatorView setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:separatorView];
    
}

#pragma mark -
#pragma mark Set Methods

/**
 * Updates the notification cell for the given title, time, and sort order
 */
-(void)setNotificationTitle:(NSString*)title andTime:(NSDate*)time sortOrder:(int)order {
    [nameLabel setText:title];
    NSDate *cellDate = time;
    
    if(time == NULL) {
        [self setStandardColors];
        [dayLabel setText:@"..."];
        [dateLabel setText:@"Calculating"];
    }
    else if([self distanceFromToday:cellDate sortOrder:order] == 0){
        NSString *monthStr = [GeneralMethods stringFromDate:[NSDate date] withFormat:@"MMM dd"];
        
        [dateLabel setText:monthStr];
        [dayLabel setText:@"Today"];
        [self setHighlightColors];
        
    }
    else {
        NSString *dayStr = [GeneralMethods stringFromDate:cellDate withFormat:@"EEE"];
        NSString *monthStr = [GeneralMethods stringFromDate:cellDate withFormat:@"MMM dd"];
        
        [dayLabel setText:dayStr];
        [dateLabel setText:monthStr];
        [self setStandardColors];
    }
}

/**
 * Updates the view to the standard color scheme
 */
-(void)setStandardColors {
    [background setBackgroundColor:[UIColor whiteColor]];
    [backdrop setBackgroundColor:Color_CellBorder];
    
    [nameLabel setTextColor:[UIColor blackColor]];
    [dayLabel setTextColor:[UIColor blackColor]];
    [dateLabel setTextColor:[UIColor blackColor]];
    [separatorView setBackgroundColor:[UIColor lightGrayColor]];
}

/**
 * Updates the cell to the highlighted color scheme
 */
-(void)setHighlightColors {
    [background setBackgroundColor:Color_PlantLinkRed];
    [backdrop setBackgroundColor:Color_PlantLinkRed_Dark];
    
    [nameLabel setTextColor:[UIColor whiteColor]];
    [dayLabel setTextColor:[UIColor whiteColor]];
    [dateLabel setTextColor:[UIColor whiteColor]];
    [separatorView setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark -
#pragma mark Date Methods

/**
 * Returns the distance from today as an int number of days, returning 0 for negative ints based on the sort order
 */
-(int)distanceFromToday:(NSDate*)date sortOrder:(int)order {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *todayComponent = [calendar components:NSDayCalendarUnit fromDate:[NSDate date]];
    NSDateComponents *dateComponent = [calendar components:NSDayCalendarUnit fromDate:date];
    
    return abs([todayComponent day] - [dateComponent day]);
}

#pragma mark -
#pragma mark Notification Methods

/**
 * Returns the notification text for a notification model
 */
+(NSString*)displayTextForNotification:(PLNotificationModel*)notification {
    PLPlantModel *plant = [PLPlantModel initWithDictionary:[notification linkedObjectDictionary]];
    NSString *format = Notification_DisplayStrDict[[notification kind]];

    if(format == NULL || [plant name] == NULL) return @"Unknown notification";
    return [NSString stringWithFormat:format,[plant name]];
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the size for the cell
 */
+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(297, 85);
}

@end
