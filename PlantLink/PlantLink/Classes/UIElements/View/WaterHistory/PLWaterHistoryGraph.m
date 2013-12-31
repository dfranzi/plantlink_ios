//
//  PLWaterHistoryGraph.m
//  PlantLink
//
//  Created by Zealous Amoeba on 11/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLWaterHistoryGraph.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"
#import "PLItemRequest.h"

@interface PLWaterHistoryGraph() {
@private
    PLItemRequest *measurementRequest;
}

@end

@implementation PLWaterHistoryGraph

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self create];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self create];
    }
    return self;
}

-(void)create {
    [self setBackgroundColor:[UIColor whiteColor]];
    moistureHistory = @[];
    measurementRequest = [[PLItemRequest alloc] init];
}

/**
 * Sets the plant and updates the water history graph
 */
-(void)setPlant:(PLPlantModel *)plant {
    _plant = plant;
    
    if(_plant) {
        [measurementRequest getMeasurementForPlant:[plant pid] withResponse:^(NSData *data, NSError *error) {
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            moistureHistory = [PLPlantMeasurementModel modelsFromArrayOfDictionaries:jsonArray];
            moistureHistory = [[moistureHistory reverseObjectEnumerator] allObjects];
            
            // Informs the system that this view needs to be redrawn
            [self setNeedsDisplay];
        }];
    }
}

/**
 * Draws the view's rect on screen
 */
-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Sets the threshold heights and adjusts then to the screen
    float upperThresholdHieght = ([_plant upperMoistureThreshold] / 0.6);
    if(upperThresholdHieght > 1.0) upperThresholdHieght = 1.0;
    if(upperThresholdHieght < 0.0) upperThresholdHieght = 0.0;
    upperThresholdHieght = self.frame.size.height - (int)floorf(upperThresholdHieght*self.frame.size.height);
    
    float lowerThresholdHeight = ([_plant lowerMoistureThreshold] / 0.6);
    if(lowerThresholdHeight > 1.0) lowerThresholdHeight = 1.0;
    if(lowerThresholdHeight < 0.0) lowerThresholdHeight = 0.0;
    lowerThresholdHeight = self.frame.size.height - (int)floorf(lowerThresholdHeight*self.frame.size.height);

    // Sets the fill color and draws the two red moisture indicator rectangles
    CGContextSetFillColorWithColor(context, RGB(253.0, 233.0, 241.0).CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, upperThresholdHieght));
    CGContextFillRect(context, CGRectMake(0, lowerThresholdHeight, self.frame.size.width, self.frame.size.height - lowerThresholdHeight));
    
    // Draws all the line indicators on the graph
    for(NSNumber *num in @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:upperThresholdHieght],[NSNumber numberWithInt:lowerThresholdHeight],[NSNumber numberWithInt:self.frame.size.height]]) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, [num intValue]);
        CGContextAddLineToPoint(context, self.frame.size.width,[num intValue]);

        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, RGB(192.0, 192.0, 192.0).CGColor);
        CGContextStrokePath(context);

    }
    
    
    // Calculates the proper increment based on the number of moisture points
    int increment = self.frame.size.width / [moistureHistory count];
    int half = (int)increment/2.0;
    
    // Draws the lines to indicate the moisture history
    if([moistureHistory count] > 2) {
        for(int i = 0; i < [moistureHistory count]-1; i++) {
            PLPlantMeasurementModel *measurement = moistureHistory[i];
            PLPlantMeasurementModel *measurement2 = moistureHistory[i+1];

            int m1 = [self heightForMoisture:[measurement moisture]];
            int m2 = [self heightForMoisture:[measurement2 moisture]];
            
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, increment*i+half, m1 );
            CGContextAddCurveToPoint(context, increment*i+half, m1, increment*(i+1)+half, m2, increment*(i+1)+half, m2);
            CGContextSetLineWidth(context, 2);
            CGContextSetStrokeColorWithColor(context, RGB(38.0, 171.0, 220.0).CGColor);
            CGContextStrokePath(context);

        }
    }
    
    // Draws the circles to indicate the moisutre history
    CGContextSetFillColorWithColor(context, RGB(38.0, 171.0, 220.0).CGColor);
    int index = 0;
    for(PLPlantMeasurementModel *measurement in moistureHistory) {
        index = index + 1;
        
        int m1 = [self heightForMoisture:[measurement moisture]];
        CGContextFillEllipseInRect(context, CGRectMake(index*increment-20-7, m1-7, 14, 14));
    }
    
}

/**
 * Returns the height on the graph for a moisture level, taking into account graph thresholds
 */
-(float)heightForMoisture:(float)moisture {
    if(moisture > 0.6) moisture = 0.6;
    if(moisture < 0.0) moisture = 0.0;
    
    moisture = moisture / 0.6;
    int height = self.frame.size.height - (int)floorf(moisture*self.frame.size.height);
    return height;
}

@end
