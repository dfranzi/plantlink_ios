//
//  PLNotificationViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationViewController.h"

@interface PLNotificationViewController() {
@private
}

@end

@implementation PLNotificationViewController

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
