//
//  AbstractRequestProtocol.h
//  eatible
//
//  Created by Zealous Amoeba on 5/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

@class AbstractRequest;
@protocol AbstractRequestDelegate <NSObject>
@optional
-(void)noInternetFound:(AbstractRequest*)request;
-(void)requestDidFail:(AbstractRequest*)request;
-(void)requestDidStart:(AbstractRequest*)request;
-(void)requestDidFinish:(AbstractRequest*)request;
@end
