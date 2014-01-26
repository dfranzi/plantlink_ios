//
//  PLPlantScheduleCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantScheduleCell.h"

#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"

@implementation PLPlantScheduleCell

#pragma mark -
#pragma mark Setters

/**
 * Updates the cell for the given plant model
 */
-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    if([self model]) {
        NSDate *predictedWaterDate = [[[self model] lastMeasurement] predictedWaterDate];
        NSString *dateStr = [GeneralMethods stringFromDate:predictedWaterDate withFormat:@"EEE, MMMM dd"];
        NSString *waterOnText = [NSString stringWithFormat:@"Water on %@",dateStr];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:waterOnText];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:19] range:NSMakeRange(0,8)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:19] range:NSMakeRange(8,[waterOnText length]-8)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:Color_PlantLinkBlue range:NSMakeRange(8,[waterOnText length]-8)];
        [waterOnLabel setAttributedText:attrStr];
    }
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the height of the cell
 */
+(CGFloat)heightForContent:(NSDictionary*)content {
    return 123+[super heightForContent:content];
}

@end
