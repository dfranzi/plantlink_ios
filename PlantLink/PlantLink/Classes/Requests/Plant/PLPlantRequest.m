//
//  PLPlantRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantRequest.h"

@implementation PLPlantRequest

-(id)initGetAllUserPlantsRequest {
    if(self = [super initAbstractRequest]) {
        _pid = @"";
        _name = @"";
        _plantType = @"";
        _soilType = @"";
        _linkName = @"";
        _linkSerial = @"";
        _color = @"";
        [self setType:Request_GetAllPlants];
    }
    return self;
}

-(id)initAddUserPlantRequestWithName:(NSString*)name plantType:(NSString*)plantType andSoilType:(NSString*)soilType {
    if(self = [super initAbstractRequest]) {
        _pid = @"";
        _name = name;
        _plantType = plantType;
        _soilType = soilType;
        _linkName = @"";
        _linkSerial = @"";
        _color = @"";
        [self setType:Request_AddPlant];
    }
    return self;
}

-(id)initRemoveUserPlantRequestWithPlantId:(NSString*)pid {
    if(self = [super initAbstractRequest]) {
        _pid = pid;
        _name = @"";
        _plantType = @"";
        _soilType = @"";
        _linkName = @"";
        _linkSerial = @"";
        _color = @"";
        [self setType:Request_RemovePlant];
    }
    return self;
}

-(id)initEditUserPlantRequestWithName:(NSString*)name plantType:(NSString*)plantType andSoilType:(NSString*)soilType {
    if(self = [super initAbstractRequest]) {
        _pid = @"";
        _name = name;
        _plantType = plantType;
        _soilType = soilType;
        _linkName = @"";
        _linkSerial = @"";
        _color = @"";
        [self setType:Request_EditPlant];
    }
    return self;
}

#pragma mark -
#pragma mark Edit Methods

-(void)editRequest:(NSMutableURLRequest *)request {
    [request addValue:API_Version forHTTPHeaderField:HTTP_Header_APIVersion];
    
    if([self type] != Request_AddPlant && [self type] != Request_EditPlant) return;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[PostKey_Name] = _name;
    dict[PostKey_PlantType] = _plantType;
    dict[PostKey_SoilType] = _soilType;
    
    if(![_linkName isEqualToString:@""]) dict[PostKey_LinkName] = _linkName;
    if(![_linkSerial isEqualToString:@""])dict[PostKey_LinkSerial] = _linkSerial;
    if(![_color isEqualToString:@""])dict[PostKey_Color] = _color;
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    [request setHTTPBody:data];
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    [self setBaseURLStr:URLStr_Base];
    
    if([self type] == Request_GetAllPlants) [self startGetAllUserPlantsRequest];
    else if([self type] == Request_AddPlant) [self startAddPlantRequest];
    else if([self type] == Request_EditPlant) [self startEditPlantRequest];
    else if([self type] == Request_RemovePlant) [self startRemovePlantRequest];
    [super startRequest];
}

-(void)startGetAllUserPlantsRequest {
    [self setURLExtStr:URLStr_Plant];
}

-(void)startAddPlantRequest {
    [self setURLExtStr:URLStr_Plant];
    [self setRequestMethod:HTTP_Post];
}

-(void)startEditPlantRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_Plant_Id,_pid]];
    [self setRequestMethod:HTTP_Put];
}

-(void)startRemovePlantRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_Plant_Id,_pid]];
    [self setRequestMethod:HTTP_Delete];
}

@end
