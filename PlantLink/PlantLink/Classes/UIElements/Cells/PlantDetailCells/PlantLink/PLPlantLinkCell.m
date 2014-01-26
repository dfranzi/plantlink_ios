//
//  PLPlantLinkCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantLinkCell.h"

#import "PLUserManager.h"
#import "PLPlantModel.h"
#import "PLPlantDetailViewController.h"
#import "PLPlantMeasurementModel.h"
#import "PLBatteryImageView.h"
#import "PLSignalImageView.h"
#import "PLItemRequest.h"

@interface PLPlantLinkCell() {
@private
    PLItemRequest *linkRequest;
}

@end

@implementation PLPlantLinkCell

#pragma mark -
#pragma mark IBAction Methods

/**
 * Called when the disconnect link button is pushed, and shows an alert asking the user if they are sure to take the action
 */
-(IBAction)disconnectLinkPushed:(id)sender {
    UIAlertView *linkAlert = [[UIAlertView alloc] initWithTitle:@"Are You Sure?" message:@"Are you sure that you want to disconnect the link from this plant?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Disconnect", nil];
    [linkAlert show];
}

#pragma mark -
#pragma mark Alert Methods

/**
 * Called when the alert view buttons are clicked, updates the plant if necessary and dismissed the view
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex != [alertView cancelButtonIndex]) {
        linkRequest = [[PLItemRequest alloc] init];
        [linkRequest editPlant:[[self model] pid] paramDict:@{PostKey_LinkKeys : @[]} withResponse:^(NSData *data, NSError *error) {
            PLUserManager *userManager = [PLUserManager initializeUserManager];
            [userManager setPlantReloadTrigger:YES];
            [[self enclosingController] dismissViewControllerAnimated:YES completion:^{}];
        }];
    }
}

#pragma mark -
#pragma mark Setters 

/**
 * Updates the cell to the given plant
 */
-(void)setModel:(PLPlantModel *)model {
    [bottomBorder setAlpha:0.0f];
    [self setClipsToBounds:YES];
    
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
    if([content.allKeys containsObject:@"EditMode"]) return 150+[super heightForContent:content];
    return 100+[super heightForContent:content];
}

@end
