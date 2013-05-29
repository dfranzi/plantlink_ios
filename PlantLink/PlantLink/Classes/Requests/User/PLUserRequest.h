//
//  PLUserRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLUserRequest : AbstractRequest
@property(nonatomic, strong, readonly) NSString *email;
@property(nonatomic, strong, readonly) NSString *password;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSString *zipCode;

-(id)initLoginUserRequestWithEmail:(NSString*)email andPassword:(NSString*)password;
-(id)initRegisterUserRequestWithEmail:(NSString*)email name:(NSString*)name password:(NSString*)password andZipCode:(NSString*)zipCode;

-(id)initGetUserRequest;
-(id)initLogoutUserRequest;

-(id)initPasswordResetRequestWithEmail:(NSString*)email;

@end
