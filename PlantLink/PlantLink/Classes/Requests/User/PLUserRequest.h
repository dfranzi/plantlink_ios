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
@property(nonatomic, strong) NSString *email;

// The password of the user
@property(nonatomic, strong) NSString *password;

// The full name of the user
@property(nonatomic, strong) NSString *name;

// The zip code of the user
@property(nonatomic, strong) NSString *zipCode;

// The serial number of the user's base station
@property(nonatomic, strong) NSString *serial;

// Whether the user wants to recieve email alerts
@property(nonatomic, assign) BOOL emailAlerts;

// Whether the user wants to recieve text alerts
@property(nonatomic, assign) BOOL textAlerts;

// Whether the user wants to recieve push alerts
@property(nonatomic, assign) BOOL pushAlerts;

/*
 * Attempts to log in the user with the passed in email and password
 */
-(id)initLoginUserRequestWithEmail:(NSString*)email andPassword:(NSString*)password;

/*
 * Attempts to register a new user with the passed in email, name password and zipcode
 */
-(id)initRegisterUserRequestWithEmail:(NSString*)email name:(NSString*)name password:(NSString*)password andZipCode:(NSString*)zipCode andBaseStationSerial:(NSString*)serial;

/*
 * Retrieves the information associated with the currently logged in user
 */
-(id)initGetUserRequest;

/*
 *
 */
-(id)initUpdateUserRequest;

/*
 * Logs out the currently logged in user
 */
-(id)initLogoutUserRequest;

/*
 * Sends a password reset email to the passed in email address
 */
-(id)initPasswordResetRequestWithEmail:(NSString*)email;

@end
