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

-(void)setTitle:(NSString*)title {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0]];
    
    [titleLabel sizeToFit];
    [titleLabel setFrame:CGRectMake(0, 0, titleLabel.frame.size.width+26, self.frame.size.height)];
    
    [self setLeftView:titleLabel];
    [self setLeftViewMode:UITextFieldViewModeAlways];
}

#pragma mark -
#pragma mark Bounds Methods

-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 14, 0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

#pragma mark -
#pragma mark Validation Methods

-(void)showValidationError {
    
}

-(void)resetValidation {
    
}

-(BOOL)validForValidationType:(NSString*)validationType {
    if([validationType isEqualToString:ValidationType_Email]) {
        if([GeneralMethods validateEmailFormat:[self text]]) [self resetValidation];
        else {
            [self showValidationError];
            return NO;
        }
    }
    else if([validationType isEqualToString:ValidationType_Empty]) {
        if([[self text] isEqualToString:@""]) {
            [self showValidationError];
            return NO;
        }
        else [self resetValidation];
    }
    return YES;
}

@end
