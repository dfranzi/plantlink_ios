//
//  PLPlantLinkCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantLinkCell.h"

@implementation PLPlantLinkCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 100+[super heightForContent:content];
}

@end
