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

-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    if([self model]) {
        NSDate *predictedWaterDate = [[[self model] lastMeasurement] predictedWaterDate];
        NSString *dateStr = [GeneralMethods stringFromDate:predictedWaterDate withFormat:@"EEE, MMM dd"];
        NSString *waterOnText = [NSString stringWithFormat:@"Water on %@",dateStr];
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:waterOnText];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:25] range:NSMakeRange(0,8)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-Bold" size:25] range:NSMakeRange(8,[waterOnText length]-8)];
        [waterOnLabel setAttributedText:attrStr];
    }
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 123+[super heightForContent:content];
}

@end
