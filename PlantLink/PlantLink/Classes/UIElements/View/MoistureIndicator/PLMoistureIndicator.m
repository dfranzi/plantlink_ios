//
//  PLMoistureIndicator.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMoistureIndicator.h"

@interface PLMoistureIndicator() {
@private
    UIImageView *leftCircle;
    UIImageView *leftCenterCircle;
    UIImageView *centerCircle;
    UIImageView *rightCenterCircle;
    UIImageView *rightCircle;
    
    UILabel *tooDryLabel;
    UILabel *justRightLabel;
    UILabel *tooWetLabel;
    
    UILabel *messageLabel;
}

@end

#define MoistureIndicator_Offset 50.0

@implementation PLMoistureIndicator

/**
 * Called when the view is created explicitely with a frame, sets the intial values
 */
-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self nullifyWaterCircles];
        [self initialSetup];
    }
    return self;
}

/**
 * Called when the view is created from a NSCoder, sets the intial values
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self nullifyWaterCircles];
        [self initialSetup];
    }
    return self;
}

#pragma mark -
#pragma mark Setup Methods

/**
 * Sets all the circle images to NULL
 */
-(void)nullifyWaterCircles {
    leftCircle = NULL;
    leftCenterCircle = NULL;
    centerCircle = NULL;
    rightCenterCircle = NULL;
    rightCircle = NULL;
}

/**
 * Creates the necessary image views and labels, adding them to the view
 */
-(void)initialSetup {
    float center = self.frame.size.width/2.0;
    
    leftCircle = [self addWaterCircleAtPoint:CGPointMake(center-2*MoistureIndicator_Offset, 20)];
    leftCenterCircle = [self addWaterCircleAtPoint:CGPointMake(center-MoistureIndicator_Offset, 20)];
    centerCircle = [self addWaterCircleAtPoint:CGPointMake(center, 20)];
    rightCenterCircle = [self addWaterCircleAtPoint:CGPointMake(center+MoistureIndicator_Offset, 20)];
    rightCircle = [self addWaterCircleAtPoint:CGPointMake(center+2*MoistureIndicator_Offset, 20)];
    
    tooDryLabel = [self addText:@"TOO DRY" atPoint:CGPointMake(center-2*MoistureIndicator_Offset, 45)];
    justRightLabel = [self addText:@"JUST RIGHT" atPoint:CGPointMake(center, 45)];
    tooWetLabel = [self addText:@"TOO WET" atPoint:CGPointMake(center+2*MoistureIndicator_Offset, 45)];
    
    messageLabel = [self addText:@"Link Missing" atPoint:CGPointMake(center, 25)];
    [messageLabel setFrame:CGRectMake(0, 0, 240, 40)];
    [messageLabel setCenter:CGPointMake(center, 25)];
    [messageLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:22.0]];
    [messageLabel setTextColor:Color_PlantLinkRed];
    [messageLabel setContentMode:UIViewContentModeCenter];
    [messageLabel setNumberOfLines:2];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

/**
 * Adds a water circle at a given point
 */
-(UIImageView*)addWaterCircleAtPoint:(CGPoint)center {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    [imageView setImage:[UIImage imageNamed:Image_WaterCircle_Empty]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setCenter:center];
    [self addSubview:imageView];
    return imageView;
}

/**
 * Adds a text field at a given point with the specified text
 */
-(UILabel*)addText:(NSString*)text atPoint:(CGPoint)center {
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 21)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0]];
    [textLabel setTextColor:[UIColor blackColor]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setText:text];
    [textLabel sizeToFit];
    [textLabel setCenter:center];
    [self addSubview:textLabel];
    
    return textLabel;
    
}

#pragma mark -
#pragma mark Setters

/**
 * Sets the message on the moisture indicator, either a text message or a moisture number
 */
-(void)setStatus:(NSString*)status {
    if(!status) status = @"";
    
    if([@"012345" rangeOfString:status].location != NSNotFound) {
        NSNumber *statusNum = (NSNumber*)status;
        [self setMoistureLevel:[statusNum intValue]];
    }
    else {
        [self setStatusStr:status];
    }
}

/**
 * Updates the moisture level by indicating the moisture with a specific water circle image
 */
-(void)setMoistureLevel:(int)moistureLevel {
    [messageLabel setAlpha:0.0f];
    
    NSArray *moistureCircles = @[leftCircle,leftCenterCircle,centerCircle,rightCenterCircle,rightCircle];
    for(UIImageView *view in moistureCircles) {
        [view setAlpha:1.0f];
        [view setImage:[UIImage imageNamed:Image_WaterCircle_Empty]];
    }
    
    NSArray *labels = @[tooDryLabel,justRightLabel,tooWetLabel];
    for(UILabel *label in labels) [label setAlpha:1.0f];
    
    _onLowestMoisture = moistureLevel == 0;
    if(_onLowestMoisture) [leftCircle setImage:[UIImage imageNamed:Image_WaterCircle_Red]];
    else if(moistureLevel == 1) [leftCenterCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(moistureLevel == 2) [centerCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(moistureLevel == 3) [rightCenterCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else [rightCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
}

/**
 * Updates the information on the view to display a status string, showing any options if necessary
 */
-(void)setStatusStr:(NSString*)statusStr {
    [messageLabel setAlpha:1.0f];
    [messageLabel setText:statusStr];
    
    NSArray *moistureSubviews = @[leftCircle,leftCenterCircle,centerCircle,rightCenterCircle,rightCircle,tooDryLabel,justRightLabel,tooWetLabel];
    for(UIView *view in moistureSubviews) [view setAlpha:0.0f];
    
    if([statusStr isEqualToString:@"Link Missing"]) [messageLabel setTextColor:Color_PlantLinkRed];
    else [messageLabel setTextColor:SHADE(0.25*255.0)];
}

@end
