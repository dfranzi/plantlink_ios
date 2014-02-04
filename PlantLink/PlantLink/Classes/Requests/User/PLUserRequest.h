//
//  PLUserRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractBlockRequest.h"

@interface PLUserRequest : AbstractBlockRequest

/**
 * Login in the user with an given email and password, calling the response block when done
 */
-(void)loginUserWithEmail:(NSString*)email andPassword:(NSString*)password withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Registers a user with an email, name, password, and base station calling the response block when done
 */
-(void)registerUserWithEmail:(NSString*)email name:(NSString*)name password:(NSString*)password withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Resets the password for a given email, calling the response block when done
 */
-(void)resetPasswordForEmail:(NSString*)email withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Authentication Methods

/**
 * Gets the current logged in user, calling the response block when done
 */
-(void)getUserWithResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Logs out the current user, calling the response block when done
 */
-(void)logoutWithResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Reporting Methods

/**
 * Submits a bug report with a message for the current user, calling the response block when done
 */
-(void)submitBugReportWithMessage:(NSString*)message andResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Update Methods

/**
 * Updates the user with the parameters in updates and calls the response block when complete
 */
-(void)updateUser:(NSDictionary*)updates withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark SMS Methods

/**
 * Adds a phone number on the current users account
 */
-(void)addSmsNumber:(NSString*)number withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Removes a phone number on the current users account
 */
-(void)removeSmsNumberWithKey:(NSString*)key withResponse:(void(^) (NSData *data, NSError *error))response;


@end
