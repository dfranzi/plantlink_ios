//
//  PLUserManager.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PLUserModel;
@interface PLUserManager : NSObject
@property(nonatomic, assign) BOOL loggedIn;
@property(nonatomic, strong) PLUserModel *user;

+(id)initializeUserManager;

@end
