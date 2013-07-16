//
//  PLUserHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserHomeViewController.h"

@interface PLUserHomeViewController() {
@private
}

@end

@implementation PLUserHomeViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_User_Logout object:nil];
    [self removeViewControllerStack];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
