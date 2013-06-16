//
//  PLMyGardenCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/5/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractCLCell.h"

@class PLPlantModel;
@interface PLMyGardenCell : AbstractCLCell {
    IBOutlet UILabel *plantNameLabel;
    IBOutlet UILabel *plantInfoLabel;
    IBOutlet UILabel *plantMoistureLabel;
    IBOutlet UILabel *plantBatteryLabel;
    IBOutlet UILabel *plantSignalLabel;
}
@property(nonatomic, strong) PLPlantModel *model;

@end
