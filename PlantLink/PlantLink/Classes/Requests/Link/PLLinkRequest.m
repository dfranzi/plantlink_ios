//
//  PLLinkRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/19/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLinkRequest.h"

@implementation PLLinkRequest

-(id)initDeleteLinkRequest:(NSString*)serial {
    if(self = [super initAbstractRequest]) {
        _serialNumber = serial;
        [self setType:Request_DeleteLink];
    }
    return self;
}

-(id)initGetLinkRequest:(NSString*)serial {
    if(self = [super initAbstractRequest]) {
        _serialNumber = serial;
        [self setType:Request_GetLink];
    }
    return self;
}

-(id)initListLinksRequest {
    if(self = [super initAbstractRequest]) {
        _serialNumber = @"";
        [self setType:Request_ListLinks];
    }
    return self;
}

-(id)initRegisterLinkRequest:(NSString*)serial {
    if(self = [super initAbstractRequest]) {
        _serialNumber = serial;
        [self setType:Request_RegisterLink];
    }
    return self;
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    [self setBaseURLStr:URLStr_Base];
    
    if([self type] == Request_DeleteLink) [self startDeleteLinkRequest];
    else if([self type] == Request_GetLink) [self startGetLinkRequest];
    else if([self type] == Request_ListLinks) [self startListLinksRequest];
    else if([self type] == Request_RegisterLink) [self startRegisterLinkRequest];
    
    [super startRequest];
}

-(void)startDeleteLinkRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_LinkSerial,_serialNumber]];
    [self setRequestMethod:HTTP_Delete];
}

-(void)startGetLinkRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_LinkSerial,_serialNumber]];
}

-(void)startListLinksRequest {
    [self setURLExtStr:URLStr_Link];
}

-(void)startRegisterLinkRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_LinkSerial,_serialNumber]];
    [self setRequestMethod:HTTP_Post];
}

@end
