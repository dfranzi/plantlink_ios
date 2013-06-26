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

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setCornerRadius:5.0];
        [self.layer setMasksToBounds:YES];
        
        [self.layer setShadowColor:Color_MainShadow.CGColor];
        [self.layer setShadowOffset:CGSizeMake(0, 1)];
        [self.layer setShadowOpacity:1.0];
        [self.layer setShadowRadius:0.0f];
    }
    return self;
}

-(void)highlightView {
    [self setBackgroundColor:Color_MenuButton_Down];
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
