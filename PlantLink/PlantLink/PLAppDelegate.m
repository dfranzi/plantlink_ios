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
    
    NSDictionary *textAttributes = @{
                            UITextAttributeTextColor:[UIColor whiteColor],
                      UITextAttributeTextShadowColor:[UIColor clearColor],
                     UITextAttributeTextShadowOffset:[NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)],
    };
    
    UIImage *backButtonImage = [[UIImage imageNamed:Image_NavigationBackButton] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 6)];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];
    [[UINavigationBar appearance] setShadowImage:[GeneralMethods imageWithColor:Color_MainShadow andSize:CGSizeMake(1, 1)]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:Color_NavigationBar];
    
    return YES;
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
