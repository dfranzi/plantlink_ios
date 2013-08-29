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

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToUserHome];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)yesPushed:(id)sender {
    [sharedUser setAddPlantTrigger:YES];
    [super nextPushed:nil];
}

-(IBAction)laterPushed:(id)sender {
    [sharedUser setAddPlantTrigger:NO];
    [super nextPushed:nil];
}

@end
