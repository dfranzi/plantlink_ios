//
//  PLSyncLinkViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSyncLinkViewController.h"

@interface PLSyncLinkViewController() {
@private
}

@end

@implementation PLSyncLinkViewController

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
    [self performSegueWithIdentifier:Segue_ToAssociateValve sender:self];
}


@end
