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
#pragma mark IBAction Methods

-(IBAction)disconnectLinkPushed:(id)sender {

}

-(IBAction)addValvePushed:(id)sender {
    
}

#pragma mark -
#pragma mark Display Methods

-(void)showEdit {
    [super showEdit];
    [self showLinkOptions];
}

-(void)hideEdit {
    [super hideEdit];
    [self showLinkInfo];
}

-(void)showLinkInfo {
    [UIView animateWithDuration:0.3 animations:^{
        [batteryImage setAlpha:1.0f];
        [batteryLabel setAlpha:1.0f];
        [wifiImage setAlpha:1.0f];
        [wifiLabel setAlpha:1.0f];
        
        [addValveButton setAlpha:0.0f];
        [removeLinkButton setAlpha:0.0f];
    }];
}

-(void)showLinkOptions {
    [UIView animateWithDuration:0.3 animations:^{
        [batteryImage setAlpha:0.0f];
        [batteryLabel setAlpha:0.0f];
        [wifiImage setAlpha:0.0f];
        [wifiLabel setAlpha:0.0f];
        
        [addValveButton setAlpha:1.0f];
        [removeLinkButton setAlpha:1.0f];
    }];
}

#pragma mark -
#pragma mark Setters 

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

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 100+[super heightForContent:content];
}

@end
