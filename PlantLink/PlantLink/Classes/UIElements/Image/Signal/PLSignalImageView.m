//
//  PLSignalImageView.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSignalImageView.h"

@implementation PLSignalImageView

#pragma mark -
#pragma mark Setters

-(void)setSignalLevel:(float)signalLevel {
    _signalLevel = signalLevel;
    
    if(_signalLevel < 0.1) [self setImage:[UIImage imageNamed:Image_Network_Empty]];
    else if(_signalLevel < 0.3) [self setImage:[UIImage imageNamed:Image_Network_Third]];
    else if(_signalLevel < 0.6) [self setImage:[UIImage imageNamed:Image_Network_TwoThird]];
    else [self setImage:[UIImage imageNamed:Image_Network_Full]];
}

@end
