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

@implementation PLPlantCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setCornerRadius:3.0];
        [self.layer setBorderWidth:1.0];
        [self.layer setBorderColor:Color_PlantCell_Border.CGColor];
        
        [separatorView setFrame:CGRectMake(18.0, 130.0, 198.0, 1.0)];
    }
    return self;
}

#pragma mark -
#pragma mark Setters

-(void)setModel:(PLPlantModel *)model {
    _model = model;
    
    if(_model) {
        [nameLabel setText:[_model name]];

        PLPlantMeasurementModel *measurement = [_model lastMeasurement];
        if(measurement && ![measurement isEqual:[NSNull null]]) {
            [self updateMoisture:[measurement moisture]];
            [self updateSignal:[measurement signal]];
            [self updateBattery:[measurement battery]];
        }
        
        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [self.layer setShouldRasterize:YES];
    }
}

#pragma mark -
#pragma mark Display Methods

-(void)updateMoisture:(float)moisture {
    NSArray *moistureCircles = @[waterCircleLeft,waterCircleLCenter,waterCircleCenter,waterCircleRCenter,waterCircleRight];
    for(UIImageView *view in moistureCircles) [view setImage:[UIImage imageNamed:Image_WaterCircle_Empty]];
    
    if(moisture < 0.2) [waterCircleLeft setImage:[UIImage imageNamed:Image_WaterCircle_Red]];
    else if(moisture < 0.4) [waterCircleLCenter setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(moisture < 0.6) [waterCircleCenter setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(moisture < 0.8) [waterCircleRCenter setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else [waterCircleRight setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
}

-(void)updateBattery:(float)battery {
    if(battery < 0.1) [batteryImage setImage:[UIImage imageNamed:Image_Battery_Empty]];
    else if(battery < 0.3) [batteryImage setImage:[UIImage imageNamed:Image_Battery_Fourth]];
    else if(battery < 0.5) [batteryImage setImage:[UIImage imageNamed:Image_Battery_Half]];
    else if(battery < 0.7) [batteryImage setImage:[UIImage imageNamed:Image_Battery_ThreeFourth]];
    else [batteryImage setImage:[UIImage imageNamed:Image_Battery_Full]];

}

-(void)updateSignal:(float)signal {
    if(signal < 0.1) [networkImage setImage:[UIImage imageNamed:Image_Network_Empty]];
    else if(signal < 0.3) [networkImage setImage:[UIImage imageNamed:Image_Network_Third]];
    else if(signal < 0.6) [networkImage setImage:[UIImage imageNamed:Image_Network_TwoThird]];
    else [networkImage setImage:[UIImage imageNamed:Image_Network_Full]];
}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(295, 179);
}


@end
