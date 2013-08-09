//
//  PLPlantSoilCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantSoilCell.h"

#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"
#import "PLMoistureIndicator.h"

@implementation PLPlantSoilCell

#pragma mark -
#pragma mark Setters

-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    if([self model]) {
        float moisture = [[[self model] lastMeasurement] moisture];
        ZALog(@"Moisture");
        [moistureIndicator setMoistureLevel:moisture];
    }
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 127+[super heightForContent:content];
}

@end
