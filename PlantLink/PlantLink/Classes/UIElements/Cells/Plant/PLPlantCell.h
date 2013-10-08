//
//  PLPlantCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLPlantModel;
@class PLMoistureIndicator;
@class PLBatteryImageView;
@class PLSignalImageView;
@interface PLPlantCell : UICollectionViewCell {
    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *waterLabel;
    
    IBOutlet PLMoistureIndicator *moistureIndicator;
    IBOutlet PLBatteryImageView *batteryImage;
    IBOutlet PLSignalImageView *signalImage;
    
    IBOutlet UIView *separatorView;
}
@property(nonatomic, strong) PLPlantModel *model;

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content;

@end
