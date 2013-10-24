//
//  PLUserRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractBlockRequest.h"

@interface PLUserRequest : AbstractBlockRequest


-(void)loginUserWithEmail:(NSString*)email andPassword:(NSString*)password withResponse:(void(^) (NSData *data, NSError *error))response;
-(void)registerUserWithEmail:(NSString*)email name:(NSString*)name password:(NSString*)password zipCode:(NSString*)zipCode andBaseStationSerial:(NSString*)baseStationSerial withResponse:(void(^) (NSData *data, NSError *error))response;
-(void)resetPasswordForEmail:(NSString*)email withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Authentication Methods

-(void)getUserWithResponse:(void(^) (NSData *data, NSError *error))response;
-(void)logoutWithResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Reporting Methods

-(void)submitBugReportWithMessage:(NSString*)message andResponse:(void(^) (NSData *data, NSError *error))response;

@end
