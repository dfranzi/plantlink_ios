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

#import "PLItemRequest.h"
#import "PLUserRequest.h"

@interface PLUserManager() {
@private
    PLUserRequest *userRequest;
    PLUserRequest *logoutRequest;
    PLItemRequest *plantRequest;
    
    PLItemRequest *soilRequest;
    PLItemRequest *plantTypeRequest;
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
        
        _loginType = Constant_LoginType_Login;
        _setupDict = [NSMutableDictionary dictionary];
        
        _addPlantTrigger = NO;
        _plantReloadTrigger = NO;
    }
    return self;
}

#pragma mark -
#pragma mark User Methods

-(void)refreshData {
    userRequest = [[PLUserRequest alloc] init];
    [userRequest getUserWithResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _user = [PLUserModel initWithDictionary:dict];
        userRequest = NULL;
    }];
    
    
    plantRequest = [[PLItemRequest alloc] init];
    [plantRequest getUserPlantsWithResponse:^(NSData *data, NSError *error) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _plants = [PLPlantModel modelsFromArrayOfDictionaries:array];
        plantRequest = NULL;
    }];
}

-(void)refreshTypes {
    plantTypeRequest = [[PLItemRequest alloc] init];
    [plantTypeRequest getPlantTypesWithResponse:^(NSData *data, NSError *error) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _plantTypes = [PLPlantTypeModel modelsFromArrayOfDictionaries:array];
        plantTypeRequest = NULL;
    }];
    
    soilRequest = [[PLItemRequest alloc] init];
    [soilRequest getSoilTypesWithResponse:^(NSData *data, NSError *error) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _soilTypes = [PLSoilModel modelsFromArrayOfDictionaries:array];
        soilRequest = NULL;
    }];
}

-(void)logout {
    _user = NULL;
    _plants = [NSMutableArray array];
    
    logoutRequest = [[PLUserRequest alloc] init];
    [logoutRequest logoutWithResponse:^(NSData *data, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_User_Logout object:nil];
    }];
}

@end
