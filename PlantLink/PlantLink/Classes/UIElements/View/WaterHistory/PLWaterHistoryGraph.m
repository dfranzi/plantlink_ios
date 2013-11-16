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
    if([moistureHistory count] > 2) {
        for(int i = 0; i < [moistureHistory count]-1; i++) {
            PLPlantMeasurementModel *measurement = moistureHistory[i];
            PLPlantMeasurementModel *measurement2 = moistureHistory[i+1];

            int m1 = self.frame.size.height - (int)floorf([measurement moisture]*self.frame.size.height);
            int m2 = self.frame.size.height - (int)floorf([measurement2 moisture]*self.frame.size.height);
            
            if(m1 < 0) m1 = 0;
            if(m1 > self.frame.size.height) m1 = self.frame.size.height;
            
            if(m2 < 0) m2 = 0;
            if(m2 > self.frame.size.height) m2 = self.frame.size.height;
            
            NSLog(@"Points (%i,%i) to (%i,%i)",increment*i+36, m1,increment*(i+1)+36, m2);
            
            CGContextBeginPath(context);
            CGContextMoveToPoint(context, increment*i+36, m1 );
            //CGContextAddLineToPoint(context, increment*(i+1)+36, m2 );
            CGContextAddCurveToPoint(context, increment*i+36+35, m1, increment*(i+1)+36-35, m2, increment*(i+1)+36, m2);
            CGContextSetLineWidth(context, 2);
            CGContextSetStrokeColorWithColor(context, RGB(38.0, 171.0, 220.0).CGColor);
            CGContextStrokePath(context);

        }
    }
    
    CGContextSetFillColorWithColor(context, RGB(38.0, 171.0, 220.0).CGColor);
    int index = 0;
    for(PLPlantMeasurementModel *measurement in moistureHistory) {
        index = index + 1;
        
        int m1 = self.frame.size.height - (int)floorf([measurement moisture]*self.frame.size.height);
        
        if(m1 < 0) m1 = 0;
        if(m1 > self.frame.size.height) m1 = self.frame.size.height;
        
        CGContextFillEllipseInRect(context, CGRectMake(index*increment-20-7, m1-7, 14, 14));
    }
    
}



@end
