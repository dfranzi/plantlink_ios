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
        
        CGSize size = CGSizeMake(self.frame.size.width, self.frame.size.height-3);
        UIImage *foreground = [GeneralMethods imageWithColor:Color_MenuButton_Up andSize:size];
        foreground = [GeneralMethods image:foreground withCornerRadius:8.0f];
        UIImage *background = [GeneralMethods imageWithColor:Color_MenuButton_Down andSize:self.frame.size];
        
        UIGraphicsBeginImageContext( self.frame.size );
        [background drawInRect:CGRectMake(0,0,self.frame.size.width,self.frame.size.height)];
        [foreground drawInRect:CGRectMake(0,0,size.width,size.height) blendMode:kCGBlendModeOverlay alpha:1.0];
        UIImage *newForeground = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        UIImage *touchDownBackground = [GeneralMethods imageWithColor:Color_MenuButton_Up andSize:self.frame.size];
        [self setBackgroundImage:newForeground forState:UIControlStateNormal];
        [self setBackgroundImage:touchDownBackground forState:UIControlStateHighlighted];
    }
    return self;
}


@end
