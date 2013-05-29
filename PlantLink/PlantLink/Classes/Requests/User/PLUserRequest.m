//
//  PLUserRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserRequest.h"

@implementation PLUserRequest

-(id)initLoginUserRequestWithEmail:(NSString*)email andPassword:(NSString*)password {
    if(self = [super initAbstractRequest]) {
        _email = email;
        _password = password;
        _name = @"";
        _zipCode = @"";
        [self setType:Request_LoginUser];
    }
    return self;
}

-(id)initRegisterUserRequestWithEmail:(NSString*)email name:(NSString*)name password:(NSString*)password andZipCode:(NSString*)zipCode {
    if(self = [super initAbstractRequest]) {
        _email = email;
        _name = name;
        _password = password;
        _zipCode = zipCode;
        [self setType:Request_RegisterUser];
    }
    return self;
}

-(id)initGetUserRequest {
    if(self = [super initAbstractRequest]) {
        _email = @"";
        _name = @"";
        _password = @"";
        _zipCode = @"";
        [self setType:Request_GetUser];
    }
    return self;
}

-(id)initLogoutUserRequest {
    if(self = [super initAbstractRequest]) {
        _email = @"";
        _name = @"";
        _password = @"";
        _zipCode = @"";
        [self setType:Request_LogoutUser];
    }
    return self;
}

-(id)initPasswordResetRequestWithEmail:(NSString*)email {
    if(self = [super initAbstractRequest]) {
        _email = email;
        _name = @"";
        _password = @"";
        _zipCode = @"";
        [self setType:Request_PasswordReset];
    }
    return self;
}

#pragma mark -
#pragma mark Edit Methods

-(void)editRequest:(NSMutableURLRequest *)request {
    if([self type] == Request_RegisterUser) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[PostKey_Email] = _email;
        dict[PostKey_Name] = _name;
        dict[PostKey_Password] = _password;
        dict[PostKey_ZipCode] = _zipCode;
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    }
    else if([self type] == Request_LoginUser) {
        NSString *authStr = [NSString stringWithFormat:HTTP_Authentication_Format,_email,_password];
        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authValue = [NSString stringWithFormat:HTTP_Authentication_Header,[AbstractRequest base64forData:authData]];
        [request addValue:authValue forHTTPHeaderField:HTTP_Header_Authorization];
    }
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    if([self type] == Request_LoginUser) [self startLoginUserRequest];
    else if([self type] == Request_RegisterUser) [self startRegisterUserRequest];
    else if([self type] == Request_GetUser) [self startGetUserRequest];
    else if([self type] == Request_LogoutUser) [self startLogoutRequest];
    else if([self type] == Request_PasswordReset) [self startPasswordResetRequest];
    [super startRequest];
}

-(void)startLoginUserRequest {
    [self setURLExtStr:URLStr_Authentication];
}

-(void)startRegisterUserRequest {
    [self setURLExtStr:URLStr_User];
    [self setRequestMethod:HTTP_Post];
}

-(void)startGetUserRequest {
    [self setURLExtStr:URLStr_User];
}

-(void)startLogoutRequest {
    [self setURLExtStr:URLStr_Logout];
}

-(void)startPasswordResetRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_PasswordReset,_email]];
    
}

@end
