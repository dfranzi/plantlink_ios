//
//  PLPlantCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantCell.h"

#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"
#import <QuartzCore/QuartzCore.h>
#import "PLMoistureIndicator.h"
#import "PLBatteryImageView.h"
#import "PLSignalImageView.h"

@interface PLPlantCell() {
    UIView *bubble;
    UILabel *bubbleLabel;
}

@end

@implementation PLPlantCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.contentView.layer setCornerRadius:3.0];
        [self.contentView.layer setBorderWidth:1.0];
        [self.contentView.layer setBorderColor:Color_PlantCell_Border.CGColor];
        [self setClipsToBounds:NO];
        
        bubble = NULL;
        bubbleLabel = NULL;
        [separatorView setFrame:CGRectMake(18.0, 130.0, 198.0, 1.0)];
    }
    return self;
}

#pragma mark -
#pragma mark Setters

-(void)setModel:(PLPlantModel *)model {
    _model = model;
    
    if(_model) {
        [nameLabel setText:[_model name]];

        PLPlantMeasurementModel *measurement = [_model lastMeasurement];
        if(measurement && ![measurement isEqual:[NSNull null]]) {
            [moistureIndicator setMoistureLevel:[measurement moisture]];
            [batteryImage setBatteryLevel:[measurement battery]];
            [signalImage setSignalLevel:[measurement signal]];
            
            if([moistureIndicator onLowestMoisture]) {
                [self updateNotificationToColor:[UIColor redColor] andText:@"WATER NOW!"];
                
                [bubble setAlpha:0.0f];
                [UIView animateWithDuration:0.3 animations:^{
                    [bubble setAlpha:1.0f];
                }];
            }
            else [bubble setAlpha:0.0];
        }
        
        [self.layer setRasterizationScale:[UIScreen mainScreen].scale];
        [self.layer setShouldRasterize:YES];
    }
}

#pragma mark -
#pragma mark Display Methods

-(void)updateNotificationToColor:(UIColor*)color andText:(NSString*)text {
    if(!bubble) [self createBubble];
    [bubble setBackgroundColor:color];
    [bubbleLabel setText:text];
    [bubble setAlpha:0.0f];
}

#pragma mark -
#pragma mark Setup Methods

-(void)createBubble {
    bubble = [[UIView alloc] initWithFrame:CGRectMake(8, -3, 70, 16)];
    [bubble.layer setCornerRadius:3.0];
    
    [bubble setBackgroundColor:[UIColor redColor]];

    [self createBubbleLabel];
    [self addSubview:bubble];
}

-(void)createBubbleLabel {
    bubbleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, bubble.frame.size.width, bubble.frame.size.height)];
    [bubbleLabel setTextColor:[UIColor whiteColor]];
    [bubbleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:9.0]];
    [bubbleLabel setText:@"WATER NOW!"];
    [bubbleLabel setBackgroundColor:[UIColor clearColor]];
    [bubbleLabel setTextAlignment:NSTextAlignmentCenter];
    [bubble addSubview:bubbleLabel];
}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(295, 179);
}


@end
