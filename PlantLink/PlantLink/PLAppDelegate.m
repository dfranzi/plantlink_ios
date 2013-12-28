//
//  PLAppDelegate.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/28/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAppDelegate.h"

#import "TestFlight.h"
#import "PLUserManager.h"

#import "PLUserRequest.h"
#import "PLUserModel.h"

@interface PLAppDelegate() {
@private
    PLUserRequest *deviceTokenRequest;
}
@end

@implementation PLAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TestFlight takeOff:@"6e791af8-376e-46e2-b170-d4d252fa19d0"];

    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    [sharedUser refreshTypes];
    
    return YES;
}

#pragma mark -
#pragma mark Notification Methods

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [deviceToken description];
    token = [token stringByReplacingOccurrencesOfString:@"<" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@">" withString:@""];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    deviceTokenRequest = [[PLUserRequest alloc] init];
    [deviceTokenRequest getUserWithResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        PLUserModel *user = [PLUserModel initWithDictionary:dict];
        
        NSArray *tokens = [user deviceTokens];
        if(![tokens containsObject:token]) {
            NSArray *array = [tokens arrayByAddingObjectsFromArray:@[token]];
            [deviceTokenRequest updateUser:@{DC_User_iOSTokens : array} withResponse:^(NSData *data, NSError *error) {}];
        }
    }];
    ZALog(@"Registered for push notifications: %@",token);
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    ZALog(@"Error: %@",error);
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    ZALog(@"User info: %@",userInfo);
    
    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"];
    if(!message) return;
    

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    
    //Clears the notifications from the notification center
    [UIApplication sharedApplication].applicationIconBadgeNumber = 1;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

#pragma mark -
#pragma mark URL Methods

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return NO;
}


@end
