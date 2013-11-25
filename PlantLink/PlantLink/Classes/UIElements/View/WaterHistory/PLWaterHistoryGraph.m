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
    moistureHistory = @[];
    
    measurementRequest = [[PLItemRequest alloc] init];
}

-(void)setPlant:(PLPlantModel *)plant {
    _plant = plant;
    
    if(_plant) {
        [measurementRequest getMeasurementForPlant:[plant pid] withResponse:^(NSData *data, NSError *error) {
            NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            moistureHistory = [PLPlantMeasurementModel modelsFromArrayOfDictionaries:jsonArray];
            moistureHistory = [[moistureHistory reverseObjectEnumerator] allObjects];
            
            [self setNeedsDisplay];
        }];
    }
}

-(void)drawRect:(CGRect)rect {
    NSLog(@"Count: %i",[moistureHistory count]);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, RGB(253.0, 233.0, 241.0).CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, self.frame.size.width, 80));
    CGContextFillRect(context, CGRectMake(0, self.frame.size.height-80, self.frame.size.width, 80));
    
    for(NSNumber *num in @[[NSNumber numberWithInt:0],[NSNumber numberWithInt:80],[NSNumber numberWithInt:self.frame.size.height-80],[NSNumber numberWithInt:self.frame.size.height]]) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, [num intValue]);
        CGContextAddLineToPoint(context, self.frame.size.width,[num intValue]);
        // [...] and so on, for all line segments
        CGContextSetLineWidth(context, 1);
        CGContextSetStrokeColorWithColor(context, RGB(192.0, 192.0, 192.0).CGColor);
        CGContextStrokePath(context);

    }
    
    // [...] and so on, for all line segments
    int increment = self.frame.size.width / [moistureHistory count];
    int half = (int)increment/2.0;
    
    if([moistureHistory count] > 2) {
        for(int i = 0; i < [moistureHistory count]-1; i++) {
            PLPlantMeasurementModel *measurement = moistureHistory[i];
            PLPlantMeasurementModel *measurement2 = moistureHistory[i+1];

            int m1 = [self heightForMoisture:[measurement moisture]];
            int m2 = [self heightForMoisture:[measurement2 moisture]];
            
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, increment*i+half, m1 );
            //CGContextAddLineToPoint(context, increment*(i+1)+36, m2 );
            CGContextAddCurveToPoint(context, increment*i+half, m1, increment*(i+1)+half, m2, increment*(i+1)+half, m2);
            CGContextSetLineWidth(context, 2);
            CGContextSetStrokeColorWithColor(context, RGB(38.0, 171.0, 220.0).CGColor);
            CGContextStrokePath(context);

        }
    }
    
    CGContextSetFillColorWithColor(context, RGB(38.0, 171.0, 220.0).CGColor);
    int index = 0;
    for(PLPlantMeasurementModel *measurement in moistureHistory) {
        index = index + 1;
        
        int m1 = [self heightForMoisture:[measurement moisture]];
        CGContextFillEllipseInRect(context, CGRectMake(index*increment-20-7, m1-7, 14, 14));
    }
    
}

-(float)heightForMoisture:(float)moisture {
    float upperThreshold = [_plant upperMoistureThreshold];
    float lowerThreshold = [_plant lowerMoistureThreshold];
    float difference = upperThreshold - lowerThreshold;
    float upperBound = upperThreshold + difference;
    float lowerBound = lowerThreshold - difference;
    
    float newValue = (moisture - lowerBound)/(upperBound - lowerBound);
    int height = self.frame.size.height - (int)floorf(newValue*self.frame.size.height);
    
    if(height < 0) height = 0;
    if(height > self.frame.size.height) height = self.frame.size.height;
    
    
    return height;
}

@end
