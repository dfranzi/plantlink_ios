//
//  PLNotificationOptionButton.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationOptionButton.h"

@implementation PLNotificationOptionButton

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:Color_Notification_OptionBackground];
        
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[self titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue-Italic" size:18.0]];
    }
    return self;
}

#pragma mark -
#pragma mark Display Methods

-(void)setBackgroundHighlight {
    [self setBackgroundColor:Color_Notification_SelectedBackground];
}

-(void)resetBackground {
    [self setBackgroundColor:Color_Notification_OptionBackground];
}


@end
