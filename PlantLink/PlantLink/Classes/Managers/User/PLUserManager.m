//
//  PLUserManager.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserManager.h"

static PLUserManager *sharedUser = nil;

@implementation PLUserManager

+(id)initializeUserManager {
    @synchronized(self) {
        if(sharedUser == nil)
            sharedUser = [[PLUserManager alloc] init];
    }
    return sharedUser;
}

-(id)init {
    if(self = [super init]) {
        
    }
    return self;
}

@end
