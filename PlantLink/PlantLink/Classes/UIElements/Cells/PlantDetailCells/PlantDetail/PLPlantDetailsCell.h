//
//  PLPlantDetailsCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@class PLPlantEditTextField;
@interface PLPlantDetailsCell : PLAbstractPlantDetailCell <UITextFieldDelegate> {
    IBOutlet PLPlantEditTextField *plantTypeTextField;
    IBOutlet PLPlantEditTextField *soilTypeTextField;
    IBOutlet PLPlantEditTextField *locationTextField;
}

@end
