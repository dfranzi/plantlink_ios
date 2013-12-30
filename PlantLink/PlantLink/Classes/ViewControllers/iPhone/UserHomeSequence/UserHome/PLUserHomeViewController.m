//
//  PLUserHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserHomeViewController.h"

#import "PLUserManager.h"

#define TabBar_Offset -7

@interface PLUserHomeViewController() {
@private
    PLUserManager *sharedUserManager;
}

@end

@implementation PLUserHomeViewController

/**
 * Sets the initial parameters of the view and its subview, registers for the logout notification
 */
-(void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_User_Logout object:nil];
    [self.navigationController.navigationItem setLeftBarButtonItem:nil];
    for(UIViewController *controller in self.viewControllers) [controller viewDidLoad];
    
    [self addTopBorder];
    [self addSeparatorAtInterval:0.25];
    [self addSeparatorAtInterval:0.50];
    [self addSeparatorAtInterval:0.75];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0000) [self.tabBar setBarStyle:UIBarStyleBlack];
    
    [self.tabBar setCenter:CGPointMake(self.tabBar.center.x, self.tabBar.center.y+5)];
    [self.navigationItem setHidesBackButton:YES];
}

/**
 * If the add plant trigger flag is set displays the add plant view
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    sharedUserManager = [PLUserManager initializeUserManager];
    if([sharedUserManager addPlantTrigger]) {
        [sharedUserManager setAddPlantTrigger:NO];
        [self performSegueWithIdentifier:Segue_ToAddPlantSequence sender:self];
    }
}

/**
 * Hides the navigation bar
 */
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark Display Methods

/**
 * Customizes the tab bar interface with a top border
 */
-(void)addTopBorder {
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, TabBar_Offset, self.tabBar.frame.size.width, 1)];
    [top setBackgroundColor:SHADE(235.0)];
    [self.tabBar addSubview:top];
}

/**
 * Customizes the tab bar interface with a set of separator borders
 */
-(void)addSeparatorAtInterval:(float)interval {
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake((int) (interval * self.tabBar.frame.size.width), TabBar_Offset+1, 1, self.tabBar.frame.size.height-TabBar_Offset-1)];
    [separator setBackgroundColor:SHADE(235.0)];
    [self.tabBar addSubview:separator];
}

#pragma mark -
#pragma mark Notification Methods

/**
 * Called when the logout notification is recieved, and transitions to the home view
 */
-(void)receivedNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:Notification_User_Logout]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
