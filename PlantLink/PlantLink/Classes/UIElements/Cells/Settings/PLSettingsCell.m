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
    
    UIView *background;
    UIView *backdrop;
    
    CGPoint originalCenter;
}

@end

@implementation PLSettingsCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView.layer setBorderColor:Color_CellBorder.CGColor];
        [self setClipsToBounds:NO];
        
        CGSize size = [PLSettingsCell sizeForContent:@{}];
        background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-2)];
        [background setBackgroundColor:[UIColor whiteColor]];
        [background.layer setCornerRadius:3.0];
        [background setClipsToBounds:YES];
        [self.contentView insertSubview:background atIndex:0];
        
        backdrop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height+1)];
        [backdrop setBackgroundColor:Color_CellBorder];
        [backdrop.layer setCornerRadius:3.0];
        [backdrop setClipsToBounds:YES];
        [self.contentView insertSubview:backdrop belowSubview:background];
        
        
        originalCenter = self.contentView.center;
    }
    return self;
}

-(void)prepareForReuse {
    [self.contentView setCenter:originalCenter];
}

#pragma mark -
#pragma mark Display Methods

-(void)setTitle:(NSString*)title {
    [titleLabel setText:title];
}

-(void)setLabel:(NSString*)label {
    [infoLabel setText:label];
}

#pragma mark -
#pragma mark Override Methods

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if(highlighted) {
        [self.contentView setCenter:CGPointMake(originalCenter.x, originalCenter.y+3)];
        [backdrop setAlpha:0.0];
    }
    else {
        [self.contentView setCenter:originalCenter];
        [backdrop setAlpha:1.0];
    }
}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(295, 110);
}

@end
