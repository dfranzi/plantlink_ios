//
//  PLUserManager.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserManager.h"

#import "PLUserModel.h"
#import "PLPlantModel.h"
#import "PLSoilModel.h"
#import "PLPlantTypeModel.h"

#import "PLPlantRequest.h"
#import "PLUserRequest.h"

#import "PLPlantTypeRequest.h"
#import "PLSoilTypeRequest.h"

@interface PLUserManager() {
@private
    PLUserRequest *userRequest;
    PLPlantRequest *plantRequest;
    
    PLSoilTypeRequest *soilRequest;
    PLPlantTypeRequest *plantTypeRequest;
}
@end

static PLUserManager *sharedUser = nil;

@implementation PLUserManager

+(id)initializeUserManager {
    @synchronized(self) {
        if(sharedUser == nil)
            sharedUser = [[PLUserManager alloc] init];
    }
    return sharedUser;
}

-(id)init {
    if(self = [super init]) {
        _loggedIn = NO;
        _user = NULL;
        
        _plants = [NSMutableArray array];
        _soilTypes = [NSMutableArray array];
        _plantTypes = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark User Methods

-(void)refreshData {
    userRequest = [[PLUserRequest alloc] initGetUserRequest];
    [userRequest setDelegate:self];
    [userRequest startRequest];
    
    plantRequest = [[PLPlantRequest alloc] initGetAllUserPlantsRequest];
    [plantRequest setDelegate:self];
    [plantRequest startRequest];
}

-(void)refreshTypes {
    
}

#pragma mark -
#pragma mark Request Methods

-(void)requestDidFinish:(AbstractRequest *)request {
    NSData *data = [request data];
    ZALog(@"Data: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);

    if([request type] == Request_GetAllPlants) [self processAllPlantsRequest:data];
    if([request type] == Request_GetUser) [self processGetUserRequest:data];
    if([request type] == Request_GetSoilTypes) [self processSoilTypesRequest:data];
    if([request type] == Request_GetPlantTypes) [self processPlantTypesRequest:data];
    
    if(plantRequest == NULL && userRequest == NULL) [self postNotification:Notification_User_UserRefreshed];
    if(soilRequest == NULL && plantTypeRequest == NULL) [self postNotification:Notification_User_TypesRefreshed];
}

-(void)requestDidFail:(AbstractRequest *)request {
    if([request type] == Request_GetAllPlants) {
        [self postNotification:Notification_User_UserRefreshFailed];
        plantRequest = NULL;
        
        [userRequest cancelRequest];
        userRequest = NULL;
    }
    
    if([request type] == Request_GetUser) {
        [self postNotification:Notification_User_UserRefreshFailed];
        userRequest = NULL;
        
        [plantRequest cancelRequest];
        plantRequest = NULL;
    }
    
    if([request type] == Request_GetSoilTypes) {
        [self postNotification:Notification_User_TypesRefreshFailed];
        soilRequest = NULL;
        
        [plantTypeRequest cancelRequest];
        plantTypeRequest = NULL;
    }
    if([request type] == Request_GetPlantTypes) {
        [self postNotification:Notification_User_TypesRefreshFailed];
        plantTypeRequest = NULL;
        
        [soilRequest cancelRequest];
        soilRequest = NULL;
    }
}

-(void)processAllPlantsRequest:(NSData*)data {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    _plants = [PLPlantModel modelsFromArrayOfDictionaries:array];
    plantRequest = NULL;
}

-(void)processGetUserRequest:(NSData*)data {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    _user = [PLUserModel modelWithDictionary:dict];
    userRequest = NULL;
}

-(void)processPlantTypesRequest:(NSData*)data {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    _plantTypes = [PLPlantTypeModel modelsFromArrayOfDictionaries:array];
    plantTypeRequest = NULL;
}

-(void)processSoilTypesRequest:(NSData*)data {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    _soilTypes = [PLSoilModel modelsFromArrayOfDictionaries:array];
    soilRequest = NULL;
}

#pragma mark -
#pragma mark Notification Methods

-(void)postNotification:(NSString*)notification {
    [[NSNotificationCenter defaultCenter] postNotificationName:notification object:nil];
}

@end
