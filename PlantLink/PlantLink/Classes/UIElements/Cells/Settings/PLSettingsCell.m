//
//  PLSettingsCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsCell.h"

@interface PLSettingsCell() {
@private
    UIColor *darkenedColor;
}

@end

@implementation PLSettingsCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        float offset = 37;
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(offset,self.contentView.frame.size.height-1,self.contentView.frame.size.width-2*offset,1)];

        float red,green,blue,alpha;
        [Color_ViewBackground getRed:&red green:&green blue:&blue alpha:&alpha];
        
        float darken = 15.0;
        red = red - darken/255.0 > 0 ? red - darken/255.0 : 0;
        green = green - darken/255.0 > 0 ? green - darken/255.0 : 0;
        blue = blue - darken/255.0 > 0 ? blue - darken/255.0 : 0;

        darkenedColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [borderView setBackgroundColor:darkenedColor];
        [self addSubview:borderView];
    }
    return self;
}

#pragma mark -
#pragma mark Display Methods

-(void)setTitle:(NSString*)title {
    [titleLabel setText:title];
}

#pragma mark -
#pragma mark Override Methods

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if(highlighted) {
        if(titleLabel) [titleLabel setTextColor:darkenedColor];
    }
    else {
        if(titleLabel) [titleLabel setTextColor:[UIColor blackColor]];
    }
}

@end
