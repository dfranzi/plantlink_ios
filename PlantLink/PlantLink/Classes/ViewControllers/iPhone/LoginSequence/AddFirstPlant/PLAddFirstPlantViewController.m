//
//  PLAddFirstPlantViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAddFirstPlantViewController.h"

#import "PLUserManager.h"

@interface PLAddFirstPlantViewController() {
@private
}

@end

@implementation PLAddFirstPlantViewController

/**
 * Sets the next segue identifier
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToUserHome];
}

/**
 * Hides the navigation controller
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark IBAction Methods

/**
 * Called if yes is selected and transitions to the user home view then displays the add plant view
 */
-(IBAction)yesPushed:(id)sender {
    [sharedUser setAddPlantTrigger:YES];
    [super nextPushed:nil];
}

/**
 * CAlled if no is selected and simply transitions to the user home view
 */
-(IBAction)laterPushed:(id)sender {
    [sharedUser setAddPlantTrigger:NO];
    [super nextPushed:nil];
}

@end
