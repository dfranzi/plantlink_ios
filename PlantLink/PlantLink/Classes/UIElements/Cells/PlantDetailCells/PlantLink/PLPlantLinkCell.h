//
//  PLPlantLinkCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@class PLBatteryImageView;
@class PLSignalImageView;
@interface PLPlantLinkCell : PLAbstractPlantDetailCell {
    IBOutlet PLBatteryImageView *batteryImage;
    IBOutlet PLSignalImageView *wifiImage;
    
    IBOutlet UILabel *batteryLabel;
    IBOutlet UILabel *wifiLabel;
    
    IBOutlet UIButton *addValveButton;
    IBOutlet UIButton *removeLinkButton;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)disconnectLinkPushed:(id)sender;
-(IBAction)addValvePushed:(id)sender;

@end
