//
//  PLContactUsViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLContactUsViewController.h"

@interface PLContactUsViewController() {
@private
}

@end

@implementation PLContactUsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:Color_ViewBackground];
}



#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
