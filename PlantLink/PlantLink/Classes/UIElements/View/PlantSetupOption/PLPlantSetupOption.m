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
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(20, self.frame.size.height-2, self.frame.size.width-40, 2)];
        [bottomBorder setBackgroundColor:SHADE(224.0)];
        [self addSubview:bottomBorder];
        
        [self setBackgroundColor:Color_ViewBackground];
        
        [numberLabel.layer setCornerRadius:12];
        [numberLabel setClipsToBounds:YES];
    }
    return self;
}


@end
