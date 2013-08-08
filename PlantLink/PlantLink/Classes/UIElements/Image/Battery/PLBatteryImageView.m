//
//  PLBatteryImageView.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLBatteryImageView.h"

@implementation PLBatteryImageView

#pragma mark -
#pragma mark Setters

-(void)setBatteryLevel:(float)batteryLevel {
    _batteryLevel = batteryLevel;
    
    if(_batteryLevel < 0.1) [self setImage:[UIImage imageNamed:Image_Battery_Empty]];
    else if(_batteryLevel < 0.3) [self setImage:[UIImage imageNamed:Image_Battery_Fourth]];
    else if(_batteryLevel < 0.5) [self setImage:[UIImage imageNamed:Image_Battery_Half]];
    else if(_batteryLevel < 0.7) [self setImage:[UIImage imageNamed:Image_Battery_ThreeFourth]];
    else [self setImage:[UIImage imageNamed:Image_Battery_Full]];
}

@end
