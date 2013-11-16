//
//  PLPlantHistoryCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@class PLPlantModel;
@class PLWaterHistoryGraph;
@interface PLPlantHistoryCell : PLAbstractPlantDetailCell {
    IBOutlet PLWaterHistoryGraph *waterHistory;
}

@end
