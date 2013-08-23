//
//  PLMenuButton.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMenuButton.h"

#import <QuartzCore/QuartzCore.h>

@interface PLMenuButton() {
@private
    CGRect originalFrame;
}

@end

@implementation PLMenuButton

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setCornerRadius:8.0f];
        [self.layer setMasksToBounds:YES];
        [self setAdjustsImageWhenHighlighted:NO];
        
        UIColor *topColor = [self backgroundColor];
        
        float red,green,blue,alpha;
        [topColor getRed:&red green:&green blue:&blue alpha:&alpha];
        
        float offset = 25.0/255.0;
        red = red - offset > 0 ? red - offset : 0;
        green = green - offset > 0 ? green - offset : 0;
        blue = blue - offset > 0 ? blue - offset : 0;
        
        UIColor *bottomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
        CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height-3);
        UIImage *foreground = [GeneralMethods imageWithColor:topColor andSize:size];
        foreground = [GeneralMethods image:foreground withCornerRadius:8.0f];
        UIImage *background = [GeneralMethods imageWithColor:bottomColor andSize:self.frame.size];
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
        [background drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        [foreground drawInRect:CGRectMake(0,0,size.width,size.height) blendMode:kCGBlendModeNormal alpha:1.0];
        UIImage *newForeground = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        UIImage *touchDownBackground = [GeneralMethods imageWithColor:topColor andSize:self.frame.size];
        [self setBackgroundImage:newForeground forState:UIControlStateNormal];
        [self setBackgroundImage:touchDownBackground forState:UIControlStateHighlighted];
        
        originalFrame = self.frame;
    }
    return self;
}

#pragma mark -
#pragma mark Override Methods

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if(highlighted) {
        [self setFrame:CGRectMake(originalFrame.origin.x, originalFrame.origin.y+3, originalFrame.size.width, originalFrame.size.height-3)];
    }
    else {
        [self setFrame:originalFrame];
    }
}


@end