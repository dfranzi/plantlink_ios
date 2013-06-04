//
//  PLValveRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLValveRequest.h"

@implementation PLValveRequest

-(id)initGetAllUserValvesRequest {
    if(self = [super initAbstractRequest]) {
        
    }
    return self;
}

-(id)initAddUserValveRequest {
    if(self = [super initAbstractRequest]) {
        
    }
    return self;
}

-(id)initDeleteValvePlantRequest {
    if(self = [super initAbstractRequest]) {
        
    }
    return self;
}

-(id)initEditUserValveRequest {
    if(self = [super initAbstractRequest]) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Edit Methods

-(void)editRequest:(NSMutableURLRequest *)request {
    [request addValue:API_Version forHTTPHeaderField:HTTP_Header_APIVersion];
}

@end
