//
//  PLPlantCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractCLCell.h"

@class PLPlantModel;
@interface PLPlantCell : AbstractCLCell {
    IBOutlet UILabel *nameLabel;
    IBOutlet UIPageControl *waterPageControl;
    IBOutlet UILabel *dateLabel;
}
@property(nonatomic, strong) PLPlantModel *model;

@end
