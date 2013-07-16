//
//  PLHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/9/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLHomeViewController.h"

#import "PLUserManager.h"

@interface PLHomeViewController() {
@private
}
@end

@implementation PLHomeViewController

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
