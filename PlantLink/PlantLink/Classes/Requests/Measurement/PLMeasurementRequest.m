//
//  PLMeasurementRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMeasurementRequest.h"

@implementation PLMeasurementRequest

-(id)initMeasurementRequestWithPlantId:(NSString*)plantId {
    if(self = [super initAbstractRequest]) {
        _plantId = plantId;
        [self setType:Request_GetMeasurements];
    }
    return self;
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    if([self type] == Request_GetMeasurements) [self startGetMeasurementsRequest];
    [super startRequest];
}

-(void)startGetMeasurementsRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_Measurement_Get,_plantId]];
}

@end
