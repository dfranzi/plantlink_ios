//
//  PLPlantItemEditButton.m
//  PlantLink
//
//  Created by Zealous Amoeba on 1/1/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import "PLPlantItemEditButton.h"

@implementation PLPlantItemEditButton

/**
 * Defaults to a hidden button (assuming edit mode is by default off)
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setAlpha:0.0f];
    }
    return self;
}

#pragma mark -
#pragma mark Setters Methods

/**
 * Automatically animated hiding and showing the button when the edit mode is changed
 */
-(void)setEditMode:(BOOL)editMode {
    _editMode = editMode;
    
    [UIView animateWithDuration:0.3 animations:^{
        if(_editMode) [self setAlpha:1.0f];
        else [self setAlpha:0.0f];
    }];
}

@end
