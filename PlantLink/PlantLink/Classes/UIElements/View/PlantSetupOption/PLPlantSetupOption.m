//
//  PLPlantSetupOption.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantSetupOption.h"
#import <QuartzCore/QuartzCore.h>

@implementation PLPlantSetupOption

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:Color_ViewBackground];
 
        [numberLabel.layer setCornerRadius:numberLabel.frame.size.width/2.0];
    }
    return self;
}

@end
