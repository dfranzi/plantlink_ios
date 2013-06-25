//
//  PLMenuButton.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMenuButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation PLMenuButton

-(void)drawRect:(CGRect)rect {
    [self.layer setCornerRadius:5.0];
    [self.layer setMasksToBounds:YES];
}

-(void)highlightView {
    [self setBackgroundColor:Color_MenuBUtton_Down];
}

-(void)clearHighlightView {
    [self setBackgroundColor:Color_MenuButton_Up];
}

-(void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        [self highlightView];
    } else {
        [self clearHighlightView];
    }
    [super setHighlighted:highlighted];
}


@end
