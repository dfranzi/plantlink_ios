//
//  PLPlantCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantCell.h"

#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"
#import <QuartzCore/QuartzCore.h>

@implementation PLPlantCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setCornerRadius:3.0];
        [self.layer setBorderWidth:1.0];
        [self.layer setBorderColor:Color_PlantCell_Border.CGColor];
    }
    return self;
}

#pragma mark -
#pragma mark Setters

-(void)setModel:(PLPlantModel *)model {
    _model = model;
    
    if(_model) {
        [nameLabel setText:[_model name]];
        
        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [self.layer setShouldRasterize:YES];
    }
}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(300, 130);
}


@end
