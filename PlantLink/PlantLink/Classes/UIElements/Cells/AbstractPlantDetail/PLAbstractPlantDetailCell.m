//
//  PLAbstractPlantDetailCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@interface PLAbstractPlantDetailCell() {
@private
}

@end

#define PlantInfoText_Font @"HelveticaNeue-Italic"
#define PlantInfoText_Color RGB(141.0,202.0,135.0)
#define PlantInfoText_FontSize 12.0

#define PlantInfo_BorderOffset 25

@implementation PLAbstractPlantDetailCell

/**
 * Sets the intial parameters
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(PlantInfo_BorderOffset, self.contentView.frame.size.height-1, self.contentView.frame.size.width-2*PlantInfo_BorderOffset, 1)];
        [bottomBorder setBackgroundColor:SHADE(224.0)];
        [bottomBorder setAlpha:0.5];
        [self.contentView addSubview:bottomBorder];
        
        [self.contentView setBackgroundColor:Color_ViewBackground];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

#pragma mark -
#pragma mark Reuse

/**
 * Updates the border on the cells reuse
 */
-(void)prepareForReuse {
    [self updateBorder];
}

#pragma mark -
#pragma mark Display Methods

/**
 * Updates the border based on the cells height
 */
-(void)updateBorder {
    [bottomBorder setFrame:CGRectMake(PlantInfo_BorderOffset, self.contentView.frame.size.height-1, self.contentView.frame.size.width-2*PlantInfo_BorderOffset, 1)];
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns a default height, useful for subclasses if there is a consistent change needed
 */
+(CGFloat)heightForContent:(NSDictionary*)content {
    return 0;
}


@end
