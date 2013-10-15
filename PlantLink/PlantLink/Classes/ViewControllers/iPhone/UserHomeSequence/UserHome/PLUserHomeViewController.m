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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self removeViewControllerStack];
    
    sharedUserManager = [PLUserManager initializeUserManager];
    if([sharedUserManager addPlantTrigger]) {
        [sharedUserManager setAddPlantTrigger:NO];
        [self performSegueWithIdentifier:Segue_ToAddPlantSequence sender:self];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark Navigation Methods

-(void)removeViewControllerStack {
    NSArray *controllers = self.navigationController.viewControllers;
    if([controllers count] > 2) {
        [self.navigationController setViewControllers:@[self.navigationController.viewControllers[0],self]];
    }
}

#pragma mark -
#pragma mark Display Methods

-(void)addTopBorder {
    UIView *top = [[UIView alloc] initWithFrame:CGRectMake(0, TabBar_Offset, self.tabBar.frame.size.width, 1)];
    [top setBackgroundColor:SHADE(235.0)];
    [self.tabBar addSubview:top];
}

-(void)addSeparatorAtInterval:(float)interval {
    UIView *separator = [[UIView alloc] initWithFrame:CGRectMake((int) (interval * self.tabBar.frame.size.width), TabBar_Offset+1, 1, self.tabBar.frame.size.height-TabBar_Offset-1)];
    [separator setBackgroundColor:SHADE(235.0)];
    [self.tabBar addSubview:separator];
}

#pragma mark -
#pragma mark Notification Methods

-(void)receivedNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:Notification_User_Logout]) {
        ZALog(@"Logout!");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
