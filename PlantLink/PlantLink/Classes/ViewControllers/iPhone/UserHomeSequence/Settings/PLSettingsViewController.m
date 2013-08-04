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

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *settings = [UIImage imageNamed:Image_Tab_Settings];
    UIImage *settingsHighlighted = [UIImage imageNamed:Image_Tab_SettingsHighlighted];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:settingsHighlighted withFinishedUnselectedImage:settings];
}


#pragma mark -
#pragma mark IBAction Methods

-(IBAction)logoutPushed:(id)sender {
    [sharedUser logout];
    
}


@end
