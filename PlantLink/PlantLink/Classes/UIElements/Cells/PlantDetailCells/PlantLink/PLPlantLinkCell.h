//
//  PLPlantLinkCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@interface PLPlantLinkCell : PLAbstractPlantDetailCell {
    IBOutlet UIImageView *batteryImageView;
    IBOutlet UIImageView *wifiImageView;
    
    IBOutlet UILabel *batteryLabel;
    IBOutlet UILabel *wifiLabel;
}

@end
