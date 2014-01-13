//
//  PLSmsView.m
//  PlantLink
//
//  Created by Zealous Amoeba on 1/1/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import "PLSmsView.h"
#import "PLMenuButton.h"

@interface PLSmsView() {
@private
    UILabel *smsNumberLabel;
    UIButton *removeButton;
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
#pragma mark Action Methods

/**
 * Informs the delegate the trash button was pushed, giving the sms info dict as a parameter
 */
-(void)trashPushed:(id)sender {
    [[self delegate] trashPushed:_dict];
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
    [smsNumberLabel setText:@"(xxx) xxx-xxxx"];
    [self addSubview:smsNumberLabel];
}

/**
 * Creates the remove button
 */
-(void)createRemoveButton {
    removeButton = [[UIButton alloc] initWithFrame:CGRectMake(220.0f, 0.0f, 40.0f, 40.0f)];
    [removeButton setContentMode:UIViewContentModeScaleAspectFill];
    [removeButton setImage:[UIImage imageNamed:Image_Icon_Trash] forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(trashPushed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:removeButton];
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
-(void)setDict:(NSDictionary *)dict {
    _dict = dict;
    
    [smsNumberLabel setText:dict[@"formatted_string"]];
    [verifiedIndicatorButton setTitle:dict[@"status"] forState:UIControlStateNormal];
    if(![dict[@"status"] isEqualToString:@"unverified"]) [verifiedIndicatorButton setHighlighted:YES];
}

@end
