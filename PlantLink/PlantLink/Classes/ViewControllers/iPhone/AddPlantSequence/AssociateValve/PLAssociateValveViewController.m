//
//  PLAssociateValveViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAssociateValveViewController.h"
#import "PLUserManager.h"

@interface PLAssociateValveViewController() {
@private
}

@end

@implementation PLAssociateValveViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
}


#pragma mark -
#pragma mark Actions

-(void)backPushed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)nextPushed:(id)sender {
    [sharedUser setPlantReloadTrigger:YES];
    [self dismissViewControllerAnimated:YES completion:^{}];
    //[self performSegueWithIdentifier:Segue_ToCongratulations sender:self];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)yesPushed:(id)sender {
    [self nextPushed:nil];
}

-(IBAction)noPushed:(id)sender {
    [self nextPushed:nil];
}

-(IBAction)whatIsAValvePushed:(id)sender {
    
}


@end
