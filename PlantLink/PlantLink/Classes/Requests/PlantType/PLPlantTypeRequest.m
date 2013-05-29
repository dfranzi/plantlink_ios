//
//  PLPlantTypeRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantTypeRequest.h"

@implementation PLPlantTypeRequest

-(id)initPlantTypeRequest {
    if(self = [super initAbstractRequest]) {
        [self setType:Request_GetPlantTypes];
    }
    return self;
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    if([self type] == Request_GetPlantTypes) [self startGetPlantTypesRequest];
    [super startRequest];
}

-(void)startGetPlantTypesRequest {
    [self setURLExtStr:URLStr_PlantType];
}

@end
