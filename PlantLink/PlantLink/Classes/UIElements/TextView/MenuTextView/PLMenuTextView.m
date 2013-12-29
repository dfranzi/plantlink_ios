//
//  PLMenuTextView.m
//  PlantLink
//
//  Created by Sujay Khandekar on 9/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMenuTextView.h"
#import <QuartzCore/QuartzCore.h>

@implementation PLMenuTextView

/**
 * Initializes the custom text view
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setBorderWidth:1.0f];
        [self.layer setCornerRadius:5.0f];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setBorderColor:Color_TextField_Border.CGColor];
    }
    return self;
}

@end
