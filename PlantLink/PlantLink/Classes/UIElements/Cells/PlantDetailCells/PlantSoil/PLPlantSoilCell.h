//
//  PLPlantSoilCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@class PLMoistureIndicator;
@interface PLPlantSoilCell : PLAbstractPlantDetailCell {
    IBOutlet PLMoistureIndicator *moistureIndicator;
}

@end
