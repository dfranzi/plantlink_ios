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
#pragma mark Edit Methods

-(void)editRequest:(NSMutableURLRequest *)request {
    [request addValue:API_Version forHTTPHeaderField:HTTP_Header_APIVersion];
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    [self setBaseURLStr:URLStr_Base];
    
    if([self type] == Request_GetMeasurements) [self startGetMeasurementsRequest];
    [super startRequest];
}

-(void)startGetMeasurementsRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_Measurement_Get,_plantId]];
}

@end
