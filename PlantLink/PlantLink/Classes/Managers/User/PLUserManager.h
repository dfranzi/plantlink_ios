//
//  PLUserManager.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PLUserModel;
@interface PLUserManager : NSObject
@property(nonatomic, assign) BOOL loggedIn;
@property(nonatomic, strong) PLUserModel *user;

@property(nonatomic, strong, readonly) NSArray *plants;
@property(nonatomic, strong, readonly) NSArray *soilTypes;
@property(nonatomic, strong, readonly) NSArray *plantTypes;

@property(nonatomic, strong) NSString *loginType;
@property(nonatomic, strong) NSMutableDictionary *setupDict;

@property(nonatomic, assign) BOOL addPlantTrigger;
@property(nonatomic, assign) BOOL plantReloadTrigger;

/**
 * Initializes the download manager, loading any necessary data from disk while restoring
 * any applicable sessions and information
 */
+(id)initializeUserManager;

#pragma mark -
#pragma mark Login Methods

-(void)refreshAutoLogin;
-(BOOL)shouldTryAutoLogin;
-(void)setLastUsername:(NSString*)username andPassword:(NSString*)password;
-(void)autoLoginWithCompletion:(void(^) (BOOL successful))completion;

#pragma mark -
#pragma mark User Methods

/**
 * Performs a user request updating all of the current users information (including the
 * plants NSArray)
 */
-(void)refreshData;

/**
 * Performs a type request on both Soil and Plant types updating the list of available options
 * from the server
 */
-(void)refreshTypes;

/*
 * Makes sure the current user is logged out
 */
-(void)logout;

#pragma mark -
#pragma mark Type Methods

-(NSString*)nameForPlantTypeKey:(NSString*)key;
-(NSString*)nameForSoilTypeKey:(NSString*)key;

@end
