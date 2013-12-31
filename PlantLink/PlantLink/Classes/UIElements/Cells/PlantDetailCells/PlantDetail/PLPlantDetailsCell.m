//
//  PLPlantDetailsCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailsCell.h"

#import "PLPlantModel.h"
#import "PLUserManager.h"

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
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        
        [plantTypeTextField setText:[sharedUser nameForPlantTypeKey:[[self model] plantTypeKey]]];
        [soilTypeTextField setText:[sharedUser nameForSoilTypeKey:[[self model] soilTypeKey]]];
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
