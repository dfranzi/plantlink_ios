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
#import "PLBatteryImageView.h"
#import "PLSignalImageView.h"

@implementation PLPlantLinkCell

#pragma mark -
#pragma mark Setters 

/**
 * Updates the cell to the given plant
 */
-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    if([self model]) {
        float battery = [[[self model] lastMeasurement] battery];
        float wifi = [[[self model] lastMeasurement] signal];
        int batteryPercent = battery*100;
        int signalPercent = wifi*100;
        
        [batteryImage setBatteryLevel:battery];
        [wifiImage setSignalLevel:wifi];
        
        [batteryLabel setText:[NSString stringWithFormat:@"%i%% Charge",batteryPercent]];
        [wifiLabel setText:[NSString stringWithFormat:@"%i%% Signal",signalPercent]];
    }
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the height for the cell
 */
+(CGFloat)heightForContent:(NSDictionary*)content {
    return 100+[super heightForContent:content];
}

@end
