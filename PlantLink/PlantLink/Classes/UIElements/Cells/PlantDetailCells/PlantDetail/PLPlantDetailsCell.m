//
//  PLPlantDetailsCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailsCell.h"

#import "PLPlantModel.h"
#import "PLPlantTypeModel.h"
#import "PLSoilModel.h"

@implementation PLPlantDetailsCell

#pragma mark -
#pragma mark Setters

/**
 * Updates the text fields with the set model
 */
-(void)setModel:(PLPlantModel *)model {
    [plantTypeTextField setBackgroundColor:Color_ViewBackground];
    [soilTypeTextField setBackgroundColor:Color_ViewBackground];
    [locationTextField setBackgroundColor:Color_ViewBackground];
    
    [super setModel:model];
    if([self model]) {
        PLPlantTypeModel *plantType = [[self model] plantType];
        PLSoilModel *soilType = [[self model] soilType];
        
        [plantTypeTextField setText:[plantType name]];
        [soilTypeTextField setText:[soilType name]];
        [locationTextField setText:[[self model] environment]];
    }
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the height for the cell
 */
+(CGFloat)heightForContent:(NSDictionary*)content {
    return 161+[super heightForContent:content];
}


@end
