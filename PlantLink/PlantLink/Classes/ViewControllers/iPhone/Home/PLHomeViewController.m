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


-(void)viewDidLoad {
    [super viewDidLoad];
    
    [sharedUser refreshAutoLogin];
    if([sharedUser shouldTryAutoLogin]) {
        [sharedUser autoLoginWithCompletion:^(BOOL successful) {
            if(successful) {
                [self performSegueWithIdentifier:Segue_ToUserHome sender:self];
            }
        }];
    }
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [sharedUser setPlantReloadTrigger:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)setupPushed:(id)sender {
    [sharedUser setLoginType:Constant_LoginType_Setup];
    [self performSegueWithIdentifier:Segue_ToLogin sender:self];
}

-(IBAction)loginPushed:(id)sender {
    [sharedUser setLoginType:Constant_LoginType_Login];
    [self performSegueWithIdentifier:Segue_ToLogin sender:self];
}

@end
