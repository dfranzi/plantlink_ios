//
//  PLBugReportViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLBugReportViewController.h"
#import  <QuartzCore/QuartzCore.h>

@interface PLBugReportViewController() 

@end

@implementation PLBugReportViewController


-(void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)sendPushed:(id)sender{
    
}

-(void)dismissKeyboard {
    [bugReportView resignFirstResponder];
}




@end
