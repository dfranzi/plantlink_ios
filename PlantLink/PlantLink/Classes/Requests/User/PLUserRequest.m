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

-(void)addApiVersionToRequest:(NSMutableURLRequest*)request {
    [request addValue:API_Version forHTTPHeaderField:HTTP_Header_APIVersion];
}

-(void)loginUserWithEmail:(NSString*)email andPassword:(NSString*)password withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_Authentication];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        NSString *authStr = [NSString stringWithFormat:HTTP_Authentication_Format,email,password];
        NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
        NSString *authValue = [NSString stringWithFormat:HTTP_Authentication_Header,[AbstractBlockRequest base64forData:authData]];
        [request addValue:authValue forHTTPHeaderField:HTTP_Header_Authorization];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)registerUserWithEmail:(NSString*)email name:(NSString*)name password:(NSString*)password withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_User];
    [self getUrlStr:url withMethod:HTTP_Post withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[PostKey_Email] = email;
        dict[PostKey_Name] = name;
        dict[PostKey_Password] = password;
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)resetPasswordForEmail:(NSString*)email withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_PasswordReset,email];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Authentication Methods

-(void)getUserWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_User];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)logoutWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_Logout];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Reporting Methods

-(void)submitBugReportWithMessage:(NSString*)message andResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_BugReport];
    [self getUrlStr:url withMethod:HTTP_Post withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[PostKey_Email] = [[sharedUser user] email];
        dict[PostKey_Message] = message;
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
        
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Update Methods

-(void)updateUser:(NSDictionary*)updates withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_User];
    [self getUrlStr:url withMethod:HTTP_Put withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:updates options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
        
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark SMS Methods

-(void)addSmsNumber:(NSString*)number withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_Phone];
    [self getUrlStr:url withMethod:HTTP_Post withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:@{PostKey_SMSNumber : number} options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
        
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)removeSmsNumberWithKey:(NSString*)key withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *ext = [NSString stringWithFormat:URLStr_Phone_Id,key];
    NSString *url = [URLStr_Base stringByAppendingString:ext];
    [self getUrlStr:url withMethod:HTTP_Delete withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

@end