//
//  PLPlantLinkCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantLinkCell.h"

#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"

@implementation PLPlantLinkCell

#pragma mark -
#pragma mark Setters 

-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    if([self model]) {
        int battery = [[[self model] lastMeasurement] battery]*100;
        int signal = [[[self model] lastMeasurement] signal]*100;
        
        [batteryLabel setText:[NSString stringWithFormat:@"%i%% Charge",battery]];
        [wifiLabel setText:[NSString stringWithFormat:@"%i%% Signal",signal]];
    }
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 100+[super heightForContent:content];
}

@end
