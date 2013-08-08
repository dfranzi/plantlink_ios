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

#define MoistureIndicator_Offset 50

@implementation PLMoistureIndicator

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self initialSetup];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self initialSetup];
    }
    return self;
}

#pragma mark -
#pragma mark Setup Methods

-(void)initialSetup {
    float center = self.center.x/2.0;
    
    [self addImageView:leftCircle atPoint:CGPointMake(center-2*MoistureIndicator_Offset, 25)];
    [self addImageView:leftCenterCircle atPoint:CGPointMake(center-MoistureIndicator_Offset, 25)];
    [self addImageView:centerCircle atPoint:CGPointMake(center, 25)];
    [self addImageView:rightCenterCircle atPoint:CGPointMake(center+MoistureIndicator_Offset, 25)];
    [self addImageView:rightCircle atPoint:CGPointMake(center+2*MoistureIndicator_Offset, 25)];
    
    [self addText:@"TOO DRY" atPoint:CGPointMake(center-2*MoistureIndicator_Offset, 0)];
    [self addText:@"JUST RIGHT" atPoint:CGPointMake(center, 0)];
    [self addText:@"TOO WET" atPoint:CGPointMake(center+2*MoistureIndicator_Offset, 0)];
}

-(void)addImageView:(UIImageView*)imageView atPoint:(CGPoint)center {
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:Image_WaterCircle_Empty]];
    [imageView setCenter:center];
    [self addSubview:imageView];
}

-(void)addText:(NSString*)text atPoint:(CGPoint)center {
    
}

#pragma mark -
#pragma mark Setters

-(void)setMoistureLevel:(float)moistureLevel {
    _moistureLevel = moistureLevel;
    
    NSArray *moistureCircles = @[leftCircle,leftCircle,centerCircle,rightCenterCircle,rightCircle];
    for(UIImageView *view in moistureCircles) [view setImage:[UIImage imageNamed:Image_WaterCircle_Empty]];
    
    if(_moistureLevel < 0.2) [leftCircle setImage:[UIImage imageNamed:Image_WaterCircle_Red]];
    else if(_moistureLevel < 0.4) [leftCenterCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(_moistureLevel < 0.6) [centerCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else if(_moistureLevel < 0.8) [rightCenterCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
    else [rightCircle setImage:[UIImage imageNamed:Image_WaterCircle_Full]];
}

@end
