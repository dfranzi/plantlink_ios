//
//  PLAddValveToPlantViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAddValveToPlantViewController.h"

@interface PLAddValveToPlantViewController() {
@private
}

@end

@implementation PLAddValveToPlantViewController

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)yesPushed:(id)sender {
    #warning Not properly implemented
    [self noPushed:nil];
}

-(IBAction)noPushed:(id)sender {
    #warning Does not post new plant to the server
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)whatIsAValvePushed:(id)sender {
    #warning Not yet implemented
}

@end
