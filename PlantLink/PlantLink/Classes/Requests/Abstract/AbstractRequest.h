//
//  WEAbstractRequest.h
//  Zealous Amoeba
//
//  Created by Zealous Amoeba on 5/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractRequestProtocol.h"

@interface AbstractRequest : NSObject <NSURLConnectionDelegate>
@property(nonatomic, assign) id <AbstractRequestDelegate> delegate;
@property(nonatomic, assign) RequestType type;

@property(nonatomic, strong) NSString *baseURLStr;
@property(nonatomic, strong) NSString *URLExtStr;
@property(nonatomic, strong) NSString *requestMethod;

@property(nonatomic, assign, readonly) BOOL finished;
@property(nonatomic, assign, readonly) BOOL successful;
@property(nonatomic, assign, readonly) int responseCode;
@property(nonatomic, strong, readonly) NSError *error;
@property(nonatomic, strong, readonly) NSMutableData *data;

-(id)initAbstractRequest;

#pragma mark -
#pragma mark Request Methods

-(void)startRequest;
-(void)cancelRequest;

#pragma mark -
#pragma mark Edit Methods

-(void)editRequest:(NSMutableURLRequest*)request;

#pragma mark -
#pragma mark Class Methods

+(BOOL)internetIsAvailable;
+(NSString*)base64forData:(NSData*)theData;

@end
