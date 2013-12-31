//
//  PLTextField.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation PLTextField

/**
 * Sets the intial parameters of the text field
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self.layer setCornerRadius:4.0];
        [self.layer setMasksToBounds:YES];
        [self setBorderStyle:UITextBorderStyleNone];
        
        [self.layer setBorderColor:RGB(228,238,233).CGColor];
        [self.layer setBorderWidth:2.0];
    }
    return self;
}

#pragma mark -
#pragma mark Display Methods

/**
 * Sets a text field title label and adds it as the left view, always showing the left view
 */
-(void)setTitle:(NSString*)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0]];
    [titleLabel setBackgroundColor:self.backgroundColor];
    
    [titleLabel sizeToFit];
    [titleLabel setFrame:CGRectMake(0, 0, titleLabel.frame.size.width+26, self.frame.size.height)];
    
    [self setLeftView:titleLabel];
    [self setLeftViewMode:UITextFieldViewModeAlways];
}

#pragma mark -
#pragma mark Bounds Methods

/**
 * Creates a smaller bounds range on the text field to have some whitespace for a border
 */
-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x+45, bounds.origin.y, bounds.size.width-14-40, bounds.size.height);
}

/**
 * Creates a smaller editting range on the text field to have some whitespace for a border
 */
-(CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x+45, bounds.origin.y, bounds.size.width-14-40, bounds.size.height);
}

#pragma mark -
#pragma mark Validation Methods

/**
 * Returns a boolean indicating whether the text field has a valid input
 */
-(BOOL)validForValidationType:(NSString*)validationType {
    if([validationType isEqualToString:ValidationType_Email]) {
        if(![GeneralMethods validateEmailFormat:[self text]]) return NO;
    }
    else if([validationType isEqualToString:ValidationType_Empty]) {
        if([[self text] isEqualToString:@""]) return NO;
    }
    return YES;
}

@end
