//
//  PLHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLHomeViewController.h"

@interface PLHomeViewController() {
@private
}
@end

@implementation PLHomeViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    if([self isIphone5]) [self adjustToiPhone5Screen];
    [sloganLabel setFont:[UIFont fontWithName:Font_Bariol_Light size:20.0]];
}

#pragma mark -
#pragma mark Layout Methods

-(void)adjustToiPhone5Screen {
    
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)loginPushed:(id)sender {
    [self performSegueWithIdentifier:Segue_ToLogin sender:self];
}

-(IBAction)registerPushed:(id)sender {
    [self performSegueWithIdentifier:Segue_ToRegister sender:self];
}

-(IBAction)learnMorePushed:(id)sender {
    [self performSegueWithIdentifier:Segue_ToTour sender:self];
}


@end
