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
#import "KeychainItemWrapper.h"

@interface PLUserManager() {
@private
    PLUserRequest *autoLoginRequest;
    
    PLUserRequest *userRequest;
    PLUserRequest *logoutRequest;
    PLItemRequest *plantRequest;
    
    PLItemRequest *soilRequest;
    PLItemRequest *plantTypeRequest;
    
    NSString *lastUsername;
    NSString *lastPassword;
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
        
        _soilTypes = [NSMutableArray array];
        _plantTypes = [NSMutableArray array];
        
        _loginType = Constant_LoginType_Login;
        _setupDict = [NSMutableDictionary dictionary];
        _plantEditDict = [NSMutableDictionary dictionary];
        
        _addPlantTrigger = NO;
        _plantReloadTrigger = NO;
        [self refreshAutoLogin];
    }
    return self;
}


#pragma mark -
#pragma mark Login Methods

-(void)refreshAutoLogin {
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:Constant_KeyChainItem accessGroup:nil];
    if([keychain objectForKey:(__bridge id)kSecAttrService]) {
        lastUsername = [keychain objectForKey:(__bridge id)kSecAttrService];
        lastPassword = [keychain objectForKey:(__bridge id)kSecValueData];
    }
    else {
        [keychain setObject:@"" forKey:(__bridge id)kSecAttrService];
        [keychain setObject:@"" forKey:(__bridge id)kSecValueData];
    }
}

-(BOOL)shouldTryAutoLogin {
    return ![lastUsername isEqualToString:@""];
}

-(void)setLastUsername:(NSString*)username andPassword:(NSString*)password {
    KeychainItemWrapper *keychain = [[KeychainItemWrapper alloc] initWithIdentifier:Constant_KeyChainItem accessGroup:nil];
    [keychain setObject:username forKey:(__bridge id)kSecAttrService];
    [keychain setObject:password forKey:(__bridge id)kSecValueData];
    [self registerForPush];
}

-(void)autoLoginWithCompletion:(void(^) (BOOL successful))completion {
    autoLoginRequest = [[PLUserRequest alloc] init];
    [autoLoginRequest loginUserWithEmail:lastUsername andPassword:lastPassword withResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([dict isKindOfClass:[NSArray class]]) {
            NSDictionary *error = ((NSArray*)dict)[0];
            if([error.allKeys containsObject:@"severity"] && [error[@"severity"] isEqualToString:@"Error"]) {
                [self setLastUsername:@"" andPassword:@""];
                completion(NO);
            }
        }
        else if(error) {
            [self setLastUsername:@"" andPassword:@""];
            completion(NO);
        }
        else {
            [self registerForPush];
            [self refreshUserData];
            completion(YES);
        }
    }];
}

-(void)registerForPush {
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];
}

#pragma mark -
#pragma mark User Methods

-(void)refreshUserData {
    userRequest = [[PLUserRequest alloc] init];
    [userRequest getUserWithResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        _user = [PLUserModel initWithDictionary:dict];
        userRequest = NULL;
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

    logoutRequest = [[PLUserRequest alloc] init];
    [logoutRequest logoutWithResponse:^(NSData *data, NSError *error) {}];
    [self setLastUsername:@"" andPassword:@""];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_User_Logout object:nil];
}

#pragma mark -
#pragma mark Type Methods

-(NSString*)nameForPlantTypeKey:(NSString*)key {
    for(PLPlantTypeModel *plant in _plantTypes) {
        if([key isEqualToString:[plant key]]) return [plant name];
    }
    return @"Non standard";
}

-(NSString*)nameForSoilTypeKey:(NSString*)key {
    for(PLSoilModel *soil in _soilTypes) {
        if([key isEqualToString:[soil key]]) return [soil name];
    }
    return @"Non standard";
}

@end
