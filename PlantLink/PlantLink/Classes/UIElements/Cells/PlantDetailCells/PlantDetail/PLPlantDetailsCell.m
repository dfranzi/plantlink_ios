//
//  PLPlantDetailsCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailsCell.h"

#import "PLPlantModel.h"

@implementation PLPlantDetailsCell

#pragma mark -
#pragma mark Setters

-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    if([self model]) {
        [plantTypeLabel setText:[[self model] plantTypeKey]];
        [soilTypeLabel setText:[[self model] soilTypeKey]];
        [locationLabel setText:[[self model] environment]];
    }
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 161+[super heightForContent:content];
}


@end
