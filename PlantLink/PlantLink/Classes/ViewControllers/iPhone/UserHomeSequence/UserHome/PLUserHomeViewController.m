//
//  PLUserHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserHomeViewController.h"

#import "PLUserManager.h"

@interface PLUserHomeViewController() {
@private
    PLUserManager *sharedUserManager;
}

@end

@implementation PLUserHomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_User_Logout object:nil];
    
    for(UIViewController *controller in self.viewControllers) [controller viewDidLoad];
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
#pragma mark Notification Methods

-(void)receivedNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:Notification_User_Logout]) {
        ZALog(@"Logout!");
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
