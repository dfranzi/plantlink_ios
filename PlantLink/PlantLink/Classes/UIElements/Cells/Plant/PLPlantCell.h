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
    IBOutlet UILabel *dateLabel;
    
    IBOutlet UIImageView *batteryImage;
    IBOutlet UIImageView *networkImage;
    
    IBOutlet UIImageView *waterCircleLeft;
    IBOutlet UIImageView *waterCircleLCenter;
    IBOutlet UIImageView *waterCircleCenter;
    IBOutlet UIImageView *waterCircleRCenter;
    IBOutlet UIImageView *waterCircleRight;
    
    IBOutlet UIView *separatorView;
}
@property(nonatomic, strong) PLPlantModel *model;

@end
