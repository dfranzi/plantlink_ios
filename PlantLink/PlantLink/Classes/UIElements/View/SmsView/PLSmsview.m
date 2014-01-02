//
//  PLSmsView.m
//  PlantLink
//
//  Created by Robert Maciej Pieta on 1/1/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import "PLSmsView.h"
#import "PLMenuButton.h"

@interface PLSmsView() {
@private
    UILabel *smsNumberLabel;
    PLMenuButton *verifiedIndicatorButton;
}

@end

@implementation PLSmsView

/**
 * Intializes the view and creates the subviews, adding the to the view as well
 */
-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self createSmsLabel];
        [self createVerifiedIndicator];
        [self createRemoveButton];
    }
    return self;
}

#pragma mark -
#pragma mark Create Methods

/**
 * Creates the sms label
 */
-(void)createSmsLabel {
    smsNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 140, 40)];
    [smsNumberLabel setBackgroundColor:[UIColor clearColor]];
    [smsNumberLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]];
    [smsNumberLabel setTextColor:[UIColor blackColor]];
    [smsNumberLabel setText:@"(224) 766-9663"];
    [self addSubview:smsNumberLabel];
}

/**
 * Creates the remove button
 */
-(void)createRemoveButton {
    _removeButton = [[UIButton alloc] initWithFrame:CGRectMake(220.0f, 0.0f, 40.0f, 40.0f)];
    [_removeButton setContentMode:UIViewContentModeScaleAspectFill];
    [_removeButton setImage:[UIImage imageNamed:Image_Icon_Trash] forState:UIControlStateNormal];
    [self addSubview:_removeButton];
}

/**
 * Creates the verified indicator view
 */
-(void)createVerifiedIndicator {
    verifiedIndicatorButton = [[PLMenuButton alloc] initWithFrame:CGRectMake(150.0f, 7.0f, 70.0f, 26.0f)];
    [verifiedIndicatorButton setTitle:@"verified" forState:UIControlStateNormal];
    [verifiedIndicatorButton setBackgroundColor:RGB(41.0f, 188.0f, 157.0f)];
    [verifiedIndicatorButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]];
    [verifiedIndicatorButton updateButtonAppearance];
    [verifiedIndicatorButton setUserInteractionEnabled:NO];
    [self addSubview:verifiedIndicatorButton];
}

#pragma mark -
#pragma mark Information Methods

/**
 * Updates the sms view to the information dictionary
 */
-(void)setSmsInfoDict:(NSDictionary*)dict {
    smsNumberLabel = dict[@"formatted_string"];
    [verifiedIndicatorButton setTitle:dict[@"status"] forState:UIControlStateNormal];
    if(![dict[@"status"] isEqualToString:@"unverified"]) [verifiedIndicatorButton setHighlighted:YES];
}

@end
