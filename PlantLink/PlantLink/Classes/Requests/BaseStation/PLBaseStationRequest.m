//
//  PLBaseStationRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLBaseStationRequest.h"

@implementation PLBaseStationRequest

-(id)initGetBaseStationRequest {
    if(self = [super initAbstractRequest]) {
        _serial = @"";
        [self setType:Request_GetAllBaseStations];
    }
    return self;
}

-(id)initAddBaseStationRequestWithSerialNumber:(NSString*)serial {
    if(self = [super initAbstractRequest]) {
        _serial = serial;
        [self setType:Request_AddBaseStation];
    }
    return self;
}

-(id)initRemoveBaseStationRequestWithSerialNumber:(NSString*)serial {
    if(self = [super initAbstractRequest]) {
        _serial = serial;
        [self setType:Request_RemoveBaseStation];
    }
    return self;
}

#pragma mark -
#pragma mark Edit Methods

-(void)editRequest:(NSMutableURLRequest *)request {
    if([self type] == Request_AddBaseStation) {
        NSDictionary *dict = [NSDictionary dictionaryWithObject:_serial forKey:PostKey_Serial];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    }
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    if([self type] == Request_GetAllBaseStations) [self startGetAllBaseStationsRequest];
    else if([self type] == Request_AddBaseStation) [self startAddBaseStationRequest];
    else if([self type] == Request_RemoveBaseStation) [self startRemoveBaseStationRquest];
    
    [super startRequest];
}

-(void)startGetAllBaseStationsRequest {
    [self setURLExtStr:URLStr_BaseStation];
    [self setRequestMethod:HTTP_Get];
}

-(void)startAddBaseStationRequest {
    [self setURLExtStr:URLStr_BaseStation];
    [self setRequestMethod:HTTP_Post];
}

-(void)startRemoveBaseStationRquest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_BaseStation_Delete,_serial]];
    [self setRequestMethod:HTTP_Delete];
}

@end
