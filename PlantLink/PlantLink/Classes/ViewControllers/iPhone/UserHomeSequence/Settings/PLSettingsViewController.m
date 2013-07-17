//
//  PLSettingsViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsViewController.h"

#import "PLUserManager.h"

@interface PLSettingsViewController() {
@private
}

@end

@implementation PLSettingsViewController

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)logoutPushed:(id)sender {
    [sharedUser logout];
    
}


@end
