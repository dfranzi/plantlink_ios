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
        UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(5, self.frame.size.height-6, self.frame.size.width-10, 2)];
        [bottomBorder setBackgroundColor:[UIColor darkGrayColor]];
        [self addSubview:bottomBorder];
        
        [self setFont:[UIFont fontWithName:@"Helvetica" size:17.0]];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

#pragma mark -
#pragma mark Bounds Methods

-(CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds , 10, 0);
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

@end
