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
}

@end
