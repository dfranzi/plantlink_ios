//
//  AbstractRequest.m
//  Zealous Amoeba
//
//  Created by Zealous Amoeba on 5/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"
#import "Reachability.h"

@interface AbstractRequest() {
@private
    NSURLConnection *_connection;
    NSMutableData *_requestData;
}
@end

@implementation AbstractRequest

-(id)initAbstractRequest {
    if(self = [super init]) {
        _name = @"";
        _baseURLStr = @"";
        _URLExtStr = @"";
        _requestType = @"GET";
        
        _finished = NO;
        _successful = NO;
        _responseCode = 0;
        _error = NULL;
        _data = NULL;
    }
    return self;
}

#pragma mark -
#pragma mark Request Methods

-(void)startRequest {
    _finished = NO;
    _successful = NO;
    
    if(![AbstractRequest internetIsAvailable]) {
        _finished = YES;
        _successful = NO;
        [self noInternetFound];
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *urlString = [_baseURLStr stringByAppendingString:_URLExtStr];
    NSURL *URL = [NSURL URLWithString:urlString];
    [request setURL:URL];
    
    [request setHTTPMethod:_requestType];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:60];
    
    [self authOnRequest:request];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [_connection start];
}

-(void)cancelRequest {
    if(_connection) {
        [_connection cancel];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

#pragma mark -
#pragma mark Request Methods

-(void)authOnRequest:(NSMutableURLRequest*)request {
    
}

#pragma mark -
#pragma mark NSURL Connection Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    _responseCode = [httpResponse statusCode];
    
    _requestData = [NSMutableData data];
    [_requestData setLength:0];
    
    [self didStart];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_requestData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    _finished = YES;
    _successful = NO;
    _error = error;
    
    [self didFail];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    //NSString *responseString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    //NSLog(@"Response string: %@",responseString);
    
    _finished = YES;
    _successful = YES;
    _error = NULL;
    
    [self didFinish];
}

#pragma mark -
#pragma mark Class Methods

+(BOOL)internetIsAvailable {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus == NotReachable) return NO;
    else return YES;
}

//Source - http://stackoverflow.com/questions/6006823/how-to-get-base64-nsstring-from-nsdata
+(NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

#pragma mark -
#pragma mark Delegate Methods

-(void)noInternetFound {
    if([self delegate] && [[self delegate] respondsToSelector:@selector(noInternetFound:)]) {
        [[self delegate] noInternetFound:self];
    }
}

-(void)didFail {
    if([self delegate] && [[self delegate] respondsToSelector:@selector(requestDidFail:)]) {
        [[self delegate] requestDidFail:self];
    }
}

-(void)didStart {
    if([self delegate] && [[self delegate] respondsToSelector:@selector(requestDidStart:)]) {
        [[self delegate] requestDidStart:self];
    }
}

-(void)didFinish {
    if([self delegate] && [[self delegate] respondsToSelector:@selector(requestDidFinish:)]) {
        [[self delegate] requestDidFinish:self];
    }
}

@end
