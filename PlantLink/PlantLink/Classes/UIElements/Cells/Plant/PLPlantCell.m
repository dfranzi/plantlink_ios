//
//  PLPlantCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantCell.h"

#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"
#import <QuartzCore/QuartzCore.h>
#import "PLMoistureIndicator.h"
#import "PLBatteryImageView.h"
#import "PLSignalImageView.h"

@interface PLPlantCell() {
    UIView *bubble;
    UILabel *bubbleLabel;
    
    UIView *background;
    UIView *backdrop;
    
    CGPoint originalCenter;
}

@end

@implementation PLPlantCell

/**
 * Initializes the cell with the proper backdrop to give the 3D push down appearance, also sets initial parameters
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView.layer setBorderColor:Color_CellBorder.CGColor];
        [self setClipsToBounds:NO];
        
        CGSize size = [PLPlantCell sizeForContent:@{}];
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
        
        bubble = NULL;
        bubbleLabel = NULL;
        [separatorView setFrame:CGRectMake(18.0, 130.0, 198.0, 1.0)];
        
        originalCenter = self.contentView.center;

        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [self.layer setShouldRasterize:YES];
    }
    return self;
}

#pragma mark -
#pragma mark Setters

/**
 * Sets the model for the cell, and updates the view to reflect the model change
 */
-(void)setModel:(PLPlantModel *)model {
    _model = model;
    
    if(_model) {
        [nameLabel setText:[_model name]];
        [moistureIndicator setStatus:[_model status]];
        
        PLPlantMeasurementModel *measurement = [_model lastMeasurement];
        if(measurement && ![measurement isEqual:[NSNull null]]) {
            [self updateCellForMeasurement:measurement];
            
        }
    }
}

/**
 * Updates the cell with measurement information
 */
-(void)updateCellForMeasurement:(PLPlantMeasurementModel*)measurement {
    [batteryImage setBatteryLevel:[measurement battery]];
    [signalImage setSignalLevel:[measurement signal]];
    
    if([moistureIndicator onLowestMoisture]) {
        [self updateNotificationToColor:[UIColor redColor] andText:@"WATER NOW!"];
        [bubble setAlpha:1.0f];
    }
    else [bubble setAlpha:0.0];
    
    NSString *baseStr = @"";
    NSString *dateStr = @"";
    UIColor *dateColor = [UIColor blackColor];
    NSDate *waterDate = [measurement predictedWaterDate];
    
    if(waterDate == NULL) [waterLabel setText:@"Calculating"];
    else {
        if([self distanceFromToday:waterDate] == 0) {
            baseStr = @"Water";
            dateStr = @"today!";
            dateColor = [UIColor redColor];
        }
        else if([self distanceFromToday:waterDate] < 7) {
            baseStr = @"Water on";
            dateStr = [GeneralMethods stringFromDate:waterDate withFormat:@"EEE"];
        }
        else {
            baseStr = @"Water on";
            dateStr = [GeneralMethods stringFromDate:waterDate withFormat:@"MMM dd"];
        }
        
        [self updateCellTextWithBaseStr:baseStr dateStr:dateStr andDateTextColor:dateColor];
    }
}

/**
 * Updates the cell text with the base string and the date string (with the given color)
 */
-(void)updateCellTextWithBaseStr:(NSString*)baseStr dateStr:(NSString*)dateStr andDateTextColor:(UIColor*)dateColor {
    NSString *waterOnStr = [NSString stringWithFormat:@"%@ %@",baseStr,dateStr];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:waterOnStr];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:14.0] range:NSMakeRange(0, [baseStr length])];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0] range:NSMakeRange([baseStr length]+1, [dateStr length])];
    [attrStr addAttribute:NSForegroundColorAttributeName value:dateColor range:NSMakeRange([baseStr length]+1, [dateStr length])];
    [waterLabel setAttributedText:attrStr];
}

#pragma mark -
#pragma mark Date Methods

/**
 * Returns the distance from today and the given date as an int, 0 if a negative number (descending order of the dates)
 */
-(int)distanceFromToday:(NSDate*)date {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:[NSDate date] toDate:date options:0];
    
    if([[NSDate date] compare:date] == NSOrderedDescending) return 0;
    return [components day];
}

#pragma mark -
#pragma mark Override Methods

/**
 * Overrides the setHighlighted: method to create the 3D push animation
 */
-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(highlighted) {
        [self.contentView setCenter:CGPointMake(originalCenter.x, originalCenter.y+3)];
        [backdrop setAlpha:0.0];
    }
    else {
        [self.contentView setCenter:originalCenter];
        [backdrop setAlpha:1.0];
    }
}

#pragma mark -
#pragma mark Display Methods

/**
 * Updates the notification bubble to the given color and text
 */
-(void)updateNotificationToColor:(UIColor*)color andText:(NSString*)text {
    if(!bubble) [self createBubble];
    [bubble setBackgroundColor:color];
    [bubbleLabel setText:text];
    [bubble setAlpha:0.0f];
}

#pragma mark -
#pragma mark Setup Methods

/**
 * Creates the bubble background and adds the bubble label
 */
-(void)createBubble {
    bubble = [[UIView alloc] initWithFrame:CGRectMake(8, -3, 85, 18)];
    [bubble.layer setCornerRadius:3.0];
    [bubble setBackgroundColor:[UIColor redColor]];

    [self createBubbleLabel];
    [self addSubview:bubble];
}

/**
 * Creates the bubble label
 */
-(void)createBubbleLabel {
    bubbleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bubble.frame.size.width, bubble.frame.size.height)];
    [bubbleLabel setTextColor:[UIColor whiteColor]];
    [bubbleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.0]];
    [bubbleLabel setText:@"WATER NOW!"];
    [bubbleLabel setBackgroundColor:[UIColor clearColor]];
    [bubbleLabel setTextAlignment:NSTextAlignmentCenter];
    [bubble addSubview:bubbleLabel];
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the size for the cell
 */
+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(295, 179);
}


@end
