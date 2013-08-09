//
//  PLPlantEditTextField.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/9/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantEditTextField.h"

#import <QuartzCore/QuartzCore.h>

@interface PLPlantEditTextField() {
@private

}

@end

@implementation PLPlantEditTextField

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setEditMode:NO];
        [self.layer setCornerRadius:2.0];
        [self.layer setMasksToBounds:YES];
        [self setBorderStyle:UITextBorderStyleNone];
        
        [self.layer setBorderColor:RGB(133,205,135).CGColor];
        [self.layer setBorderWidth:0];
    }
    return self;
}

#pragma mark -
#pragma mark Setters

-(void)setEditMode:(BOOL)editMode {
    _editMode = editMode;
    if(_editMode) [self showEdit];
    else [self hideEdit];
}

#pragma mark -
#pragma mark Bounds Methods

-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 10, 0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

#pragma mark -
#pragma mark Display Methods

-(void)showEdit {
    [self setUserInteractionEnabled:YES];
    [UIView animateWithDuration:0.3 animations:^{
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderWidth:1];
    }];
}

-(void)hideEdit {
    [self setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self setBackgroundColor:[UIColor clearColor]];
        [self.layer setBorderWidth:0];
    }];
}

@end
