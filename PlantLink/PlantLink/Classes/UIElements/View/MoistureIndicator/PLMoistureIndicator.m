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
}

@end

#define MoistureIndicator_Offset 50.0

@implementation PLMoistureIndicator

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self nullifyWaterCircles];
        [self initialSetup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self nullifyWaterCircles];
        [self initialSetup];
    }
    return self;
}

#pragma mark -
#pragma mark Setup Methods

-(void)nullifyWaterCircles {
    leftCircle = NULL;
    leftCenterCircle = NULL;
    centerCircle = NULL;
    rightCenterCircle = NULL;
    rightCircle = NULL;
}

-(void)initialSetup {
    float center = self.frame.size.width/2.0;
    
    leftCircle = [self addWaterCircleAtPoint:CGPointMake(center-2*MoistureIndicator_Offset, 20)];
    leftCenterCircle = [self addWaterCircleAtPoint:CGPointMake(center-MoistureIndicator_Offset, 20)];
    centerCircle = [self addWaterCircleAtPoint:CGPointMake(center, 20)];
    rightCenterCircle = [self addWaterCircleAtPoint:CGPointMake(center+MoistureIndicator_Offset, 20)];
    rightCircle = [self addWaterCircleAtPoint:CGPointMake(center+2*MoistureIndicator_Offset, 20)];
    
    [self addText:@"TOO DRY" atPoint:CGPointMake(center-2*MoistureIndicator_Offset, 45)];
    [self addText:@"JUST RIGHT" atPoint:CGPointMake(center, 45)];
    [self addText:@"TOO WET" atPoint:CGPointMake(center+2*MoistureIndicator_Offset, 45)];
    
    [self setBackgroundColor:[UIColor clearColor]];
}

-(UIImageView*)addWaterCircleAtPoint:(CGPoint)center {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 20)];
    [imageView setImage:[UIImage imageNamed:Image_WaterCircle_Empty]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setCenter:center];
    [self addSubview:imageView];
    return imageView;
}

-(void)addText:(NSString*)text atPoint:(CGPoint)center {
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 21)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0]];
    [textLabel setTextColor:[UIColor blackColor]];
    [textLabel setTextAlignment:NSTextAlignmentCenter];
    [textLabel setText:text];
    [textLabel sizeToFit];
    [textLabel setCenter:center];
    [self addSubview:textLabel];
    
}

#pragma mark -
#pragma mark Setters

-(void)setMoistureLevel:(int)moistureLevel {
    _moistureLevel = moistureLevel;
    
    NSArray *moistureCircles = @[leftCircle,leftCenterCircle,centerCircle,rightCenterCircle,rightCircle];
    for(UIImageView *view in moistureCircles) [view setImage:[UIImage imageNamed:Image_WaterCircle_Empty]];
    
    _onLowestMoisture = _moistureLevel == 0;
    if(_onLowestMoisture) [leftCircle setImage:[UIImage imageNamed:Image_WaterCircle_Red]];
    else if(_moistureLevel == 1) [leftCenterCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(_moistureLevel == 2) [centerCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(_moistureLevel == 3) [rightCenterCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else [rightCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
}

@end
