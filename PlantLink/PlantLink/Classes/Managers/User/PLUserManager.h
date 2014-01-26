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

//@property(nonatomic, strong, readonly) NSArray *plants;
@property(nonatomic, strong, readonly) NSArray *soilTypes;
@property(nonatomic, strong, readonly) NSArray *plantTypes;

@property(nonatomic, strong) NSString *loginType;
@property(nonatomic, strong) NSMutableDictionary *setupDict;
@property(nonatomic, strong) NSMutableDictionary *plantEditDict;

@property(nonatomic, assign) BOOL addPlantTrigger;
@property(nonatomic, assign) BOOL plantReloadTrigger;

/**
 * Initializes the download manager, loading any necessary data from disk while restoring
 * any applicable sessions and information
 */
+(id)initializeUserManager;

#pragma mark -
#pragma mark Login Methods

/**
 * Refreshes the data associated with login information in the keychain
 */
-(void)refreshAutoLogin;

/**
 * Returns a boolean indicating whether auto login is possible (ie a saved user exists)
 */
-(BOOL)shouldTryAutoLogin;

/**
 * Sets the username and password to save
 */
-(void)setLastUsername:(NSString*)username andPassword:(NSString*)password;

/**
 * Attemps to auto login, calling the completion block if successful
 */
-(void)autoLoginWithCompletion:(void(^) (BOOL successful))completion;

#pragma mark -
#pragma mark User Methods

/**
 * Performs a user request updating all of the current users account information
 */
-(void)refreshUserData;

/**
 * Performs a type request on both Soil and Plant types updating the list of available options
 * from the server
 */
-(void)refreshTypes;

/**
 * Makes sure the current user is logged out
 */
-(void)logout;

#pragma mark -
#pragma mark Type Methods

/**
 * Returns the name of the plant type given the plant type key
 */
-(NSString*)nameForPlantTypeKey:(NSString*)key;

/**
 * Returns the name of the soil type given the soil type key
 */
-(NSString*)nameForSoilTypeKey:(NSString*)key;

@end
