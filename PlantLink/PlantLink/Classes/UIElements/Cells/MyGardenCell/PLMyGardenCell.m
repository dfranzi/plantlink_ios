//
//  PLMyGardenCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/5/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMyGardenCell.h"
#import "PLPlantModel.h"

@implementation PLMyGardenCell

#pragma mark -
#pragma mark Setters

-(void)setModel:(PLPlantModel *)model {
    _model = model;
    
    if(_model) {
        [plantNameLabel setText:[model name]];
        [plantInfoLabel setText:[NSString stringWithFormat:@"%@ in %@ soil",[model plantTypeKey],[model soilTypeKey]]];
        [plantMoistureLabel setText:@"Moisture at 10%"];
        [plantSignalLabel setText:@"Signal at 30%"];
        [plantBatteryLabel setText:@"Battery at 70%"];
        
        
        if(![[model color] isEqual:[UIColor clearColor]]) [self setBackgroundColor:[model color]];
        else [self setBackgroundColor:Color_OsoGreen];
    }
}

@end
