//
//  PLUserRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLUserRequest : AbstractRequest
// The email address of the user
@property(nonatomic, strong, readonly) NSString *email;

// The password of the user
@property(nonatomic, strong, readonly) NSString *password;

// The full name of the user
@property(nonatomic, strong, readonly) NSString *name;

// The zip code of the user
@property(nonatomic, strong, readonly) NSString *zipCode;

/*
 * Attempts to log in the user with the passed in email and password
 */
-(id)initLoginUserRequestWithEmail:(NSString*)email andPassword:(NSString*)password;

/*
 * Attempts to register a new user with the passed in email, name password and zipcode
 */
-(id)initRegisterUserRequestWithEmail:(NSString*)email name:(NSString*)name password:(NSString*)password andZipCode:(NSString*)zipCode;

/*
 * Retrieves the information associated with the currently logged in user
 */
-(id)initGetUserRequest;

/*
 * Logs out the currently logged in user
 */
-(id)initLogoutUserRequest;

/*
 * Sends a password reset email to the passed in email address
 */
-(id)initPasswordResetRequestWithEmail:(NSString*)email;

@end
