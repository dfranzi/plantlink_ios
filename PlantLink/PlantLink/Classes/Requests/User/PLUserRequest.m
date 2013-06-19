//
//  PLUserRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserRequest.h"

#import "PLUserManager.h"
#import "PLUserModel.h"

@implementation PLUserRequest

-(id)initLoginUserRequestWithEmail:(NSString*)email andPassword:(NSString*)password {
    if(self = [super initAbstractRequest]) {
        _email = email;
        _password = password;
        _name = @"";
        _zipCode = @"";
        _emailAlerts = NO;
        _textAlerts = NO;
        _pushAlerts = NO;
        
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
        _emailAlerts = NO;
        _textAlerts = NO;
        _pushAlerts = NO;
        
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
        _emailAlerts = NO;
        _textAlerts = NO;
        _pushAlerts = NO;
        
        [self setType:Request_GetUser];
    }
    return self;
}

-(id)initUpdateUserRequest {
    if(self = [super initAbstractRequest]) {
        _email = @"";
        _name = @"";
        _password = @"";
        _zipCode = @"";
        _emailAlerts = NO;
        _textAlerts = NO;
        _pushAlerts = NO;
        
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        if([sharedUser loggedIn]) {
            _email = [[sharedUser user] email];
            _name = [[sharedUser user] name];
            _zipCode = [[sharedUser user] zip];
            _emailAlerts = [[sharedUser user] emailAlerts];
            _textAlerts = [[sharedUser user] textAlerts];
            _pushAlerts = [[sharedUser user] pushAlerts];
        }
        
        [self setType:Request_UpdateUser];
    }
    return self;
}

-(id)initLogoutUserRequest {
    if(self = [super initAbstractRequest]) {
        _email = @"";
        _name = @"";
        _password = @"";
        _zipCode = @"";
        _emailAlerts = NO;
        _textAlerts = NO;
        _pushAlerts = NO;
        
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
        _emailAlerts = NO;
        _textAlerts = NO;
        _pushAlerts = NO;
        
        [self setType:Request_PasswordReset];
    }
    return self;
}

#pragma mark -
#pragma mark Edit Methods

-(void)editRequest:(NSMutableURLRequest *)request {
    [request addValue:API_Version forHTTPHeaderField:HTTP_Header_APIVersion];
    
    if([self type] == Request_RegisterUser || [self type] == Request_UpdateUser) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[PostKey_Email] = _email;
        dict[PostKey_Name] = _name;
        dict[PostKey_Password] = _password;
        dict[PostKey_ZipCode] = _zipCode;
        
        if([self type] == Request_UpdateUser) {
            dict[PostKey_EmailAlerts] = @_emailAlerts;
            dict[PostKey_TextAlerts] = @_textAlerts;
            dict[PostKey_PushAlerts] = @_pushAlerts;
            
            [dict removeObjectForKey:PostKey_Password];
        }
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    }
    else if([self type] == Request_LoginUser) {
        NSString *authStr = [NSString stringWithFormat:HTTP_Authentication_Format,_email,_password];
        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authValue = [NSString stringWithFormat:HTTP_Authentication_Header,[AbstractRequest base64forData:authData]];
        [request addValue:authValue forHTTPHeaderField:HTTP_Header_Authorization];
        ZALog(@"User auth added: %@",authStr);
    }
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    [self setBaseURLStr:URLStr_Base];
    
    if([self type] == Request_LoginUser) [self startLoginUserRequest];
    else if([self type] == Request_RegisterUser) [self startRegisterUserRequest];
    else if([self type] == Request_GetUser) [self startGetUserRequest];
    else if([self type] == Request_UpdateUser) [self startGetUserRequest];
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

-(void)startUpdatedUserRequest {
    [self setURLExtStr:URLStr_User];
    [self setRequestMethod:HTTP_Put];
}


-(void)startLogoutRequest {
    [self setURLExtStr:URLStr_Logout];
}

-(void)startPasswordResetRequest {
    [self setURLExtStr:[NSString stringWithFormat:URLStr_PasswordReset,_email]];
    
}

@end
