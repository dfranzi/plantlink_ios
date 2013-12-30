//
//  PLHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/9/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLHomeViewController.h"

#import "PLUserManager.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>

@interface PLHomeViewController() {
@private
    NSDate *startDate;
}
@end

@implementation PLHomeViewController

/**
 * Loads the view, sets the initial state and calls the auto login sequence
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [loginButton setAlpha:0.0f];
    [setupButton setAlpha:0.0f];
    if(![self attemptAutoLogin]) [self fadeInButtons];
}

/**
 * Ensures that the plants will be reloaded if the user home view is reached after the home view appears
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [sharedUser setPlantReloadTrigger:YES];
}

/**
 * Hides the navigation bar
 */
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark Login Methods

/**
 * Attempts to autologin, returning whether the attempt is made or not
 */
-(BOOL)attemptAutoLogin {
    [sharedUser refreshAutoLogin];
    if([sharedUser shouldTryAutoLogin]) {
        [self autoLogin];
        return YES;
    }
    else return NO;
}

/**
 * Performs the auto login attempt, performing the segue to the user home view if successful
 */
-(void)autoLogin {
    [sharedUser autoLoginWithCompletion:^(BOOL successful) {
        if(successful) {
            [self performSegueWithIdentifier:Segue_ToUserHome sender:self];
        }
        [self fadeInButtons];
    }];
}

#pragma mark -
#pragma mark IBAction Methods

/**
 * Method called when the setup button is clicked up inside its bounds
 */
-(IBAction)setupPushed:(id)sender {
    [sharedUser setLoginType:Constant_LoginType_Setup];
    [self performSegueWithIdentifier:Segue_ToLogin sender:self];
}

/**
 * Method called when the login button is clicked up inside its bounds
 */
-(IBAction)loginPushed:(id)sender {
    [sharedUser setLoginType:Constant_LoginType_Login];
    [self performSegueWithIdentifier:Segue_ToLogin sender:self];
}

#pragma mark -
#pragma mark Animation Methods

/**
 * Fades in the login and setup button
 */
-(void)fadeInButtons {
    [UIView animateWithDuration:0.3 animations:^{
        [loginButton setAlpha:1.0f];
        [setupButton setAlpha:1.0f];
    }];
}

@end
