//
//  PLPlantEditButton.m
//  PlantLink
//
//  Created by Robert Maciej Pieta on 1/1/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import "PLPlantEditButton.h"

@interface PLPlantEditButton() {
@private
    CGRect originalFrame;
}

@end

@implementation PLPlantEditButton

/**
 * Sets the initial parameters and adds a listener for a touch up inside event to toggle between edit modes
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        _editModeOn = NO;
        originalFrame = self.frame;
        [self addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

#pragma mark -
#pragma mark Action Methods

/**
 * Toggles the edit mode when touched, posting the appropriate notification and switching the button image
 */
-(void)touchUpInside:(id)sender {
    _editModeOn = !_editModeOn;
    
    if(_editModeOn) {
        [self setImage:[UIImage imageNamed:Image_Pencil_Edit] forState:UIControlStateNormal];
        self.frame = CGRectMake(self.frame.origin.x-75, self.frame.origin.y, 126, self.frame.size.height);
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Plant_Edit object:@YES];
    }
    else {
        [self setImage:[UIImage imageNamed:Image_Pencil_Gray] forState:UIControlStateNormal];
        self.frame = originalFrame;
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Plant_Edit object:@NO];
    }
}

@end
