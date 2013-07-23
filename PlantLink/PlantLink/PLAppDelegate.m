//
//  PLAppDelegate.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/28/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAppDelegate.h"

#import "TestFlight.h"

@implementation PLAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [TestFlight takeOff:@"6e791af8-376e-46e2-b170-d4d252fa19d0"];
    [self setCustomTabBarDesign];
    
    return YES;
}

#pragma mark -
#pragma mark Display Methods

-(void)setCustomTabBarDesign {
    UIImage* tabBarBackground = [GeneralMethods imageWithColor:Color_TabBar_Background andSize:CGSizeMake(320.0, 49.0)];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    UIImage *selectedBackground = [GeneralMethods imageWithColor:Color_MenuButton_Up andSize:CGSizeMake(80.0, 49.0)];
    [[UITabBar appearance] setSelectionIndicatorImage:selectedBackground];

}

#pragma mark -
#pragma mark Notification Methods

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
}

#pragma mark -
#pragma mark URL Methods

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return NO;
}


@end
