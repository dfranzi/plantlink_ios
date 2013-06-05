//
//  PLHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLHomeViewController.h"

#import "AbstractRequest.h"
#import "PLUserRequest.h"

@interface PLHomeViewController() {
@private
    PLUserRequest *userRequest;
    BOOL next;
}
@end

@implementation PLHomeViewController

//-(void)viewDidLoad {
//    [super viewDidLoad];
//    
//    next = true;
//    
//    userRequest = [[PLUserRequest alloc] initLoginUserRequestWithEmail:@"test@oso.tc" andPassword:@"test"];
//    [userRequest setDelegate:self];
//    [userRequest startRequest];
//    
//    ZALog(@"Loaded");
//}
//
//-(void)requestDidFinish:(AbstractRequest *)request {
//    NSString *response = [[NSString alloc] initWithData:[request data] encoding:NSUTF8StringEncoding];
//    ZALog(@"Response: %@",response);
//    
//    if(next) {
//        next = false;
//        
//        userRequest = [[PLUserRequest alloc] initGetUserRequest];
//        [userRequest setDelegate:self];
//        [userRequest startRequest];
//    }
//}

@end
