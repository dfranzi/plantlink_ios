//
//  PLPlantSetupViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantSetupViewController.h"

@interface PLPlantSetupViewController() {
@private
}

@end

@implementation PLPlantSetupViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
}

#pragma mark -
#pragma mark Actions 

-(void)nextPushed:(id)sender {
    
}

@end
