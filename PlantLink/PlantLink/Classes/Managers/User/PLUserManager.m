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
#import "PLPlantRequest.h"
#import "PLUserRequest.h"

@interface PLUserManager() {
@private
    PLUserRequest *userRequest;
    PLPlantRequest *plantRequest;
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
    if([request type] == Request_GetAllPlants) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _plants = [PLPlantModel modelsFromArrayOfDictionaries:array];
        plantRequest = NULL;
    }
    if([request type] == Request_GetUser) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _user = [PLUserModel modelWithDictionary:dict];
        userRequest = NULL;
    }
    
    if(plantRequest == NULL && userRequest == NULL) {
        ZALog(@"Send notification: %i plants detected",[_plants count]);
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_User_UserRefreshed object:nil];
    }
}

@end
