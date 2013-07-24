//
//  PLMenuButton.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMenuButton.h"

#import <QuartzCore/QuartzCore.h>

@implementation PLMenuButton

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setCornerRadius:8.0f];
        [self.layer setMasksToBounds:YES];
        
        UIImage *backgroundUp = [GeneralMethods imageWithColor:Color_MenuButton_Up andSize:self.frame.size];
        UIImage *backgroundDown = [GeneralMethods imageWithColor:Color_MenuButton_Down andSize:self.frame.size];
    
        [self setBackgroundImage:backgroundUp forState:UIControlStateNormal];
        [self setBackgroundImage:backgroundDown forState:UIControlStateSelected];
    }
    return self;
}


@end
