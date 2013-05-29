//
//  PLSoilTypeRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSoilTypeRequest.h"

@implementation PLSoilTypeRequest

-(id)initSoilTypeRequest {
    if(self = [super initAbstractRequest]) {
        [self setType:Request_GetSoilTypes];
    }
    return self;
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    if([self type] == Request_GetSoilTypes) [self startGetSoilTypesRequest];
    [super startRequest];
}

-(void)startGetSoilTypesRequest {
    [self setURLExtStr:URLStr_SoilType];
}

@end
