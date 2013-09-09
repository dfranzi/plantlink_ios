//
//  PLPlantSetupViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantSetupViewController.h"

#import "PLPlantSetupOption.h"

@interface PLPlantSetupViewController() {
@private
}

@end

@implementation PLPlantSetupViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    

}

#pragma mark -
#pragma mark Actions 

-(void)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)nextPushed:(id)sender {
    [self performSegueWithIdentifier:Segue_ToConnectLink sender:self];
}

@end
