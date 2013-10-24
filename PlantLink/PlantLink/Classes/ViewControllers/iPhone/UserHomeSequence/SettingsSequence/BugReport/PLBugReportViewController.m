//
//  PLBugReportViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLBugReportViewController.h"
#import  <QuartzCore/QuartzCore.h>
#import "PLUserRequest.h"

@interface PLBugReportViewController() {
@private
    PLUserRequest *reportRequest;
}
@end

@implementation PLBugReportViewController


-(void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)sendPushed:(id)sender{
    if(![bugReportView.text isEqualToString:@""]) return;
    
    reportRequest = [[PLUserRequest alloc] init];
    [reportRequest submitBugReportWithMessage:bugReportView.text andResponse:^(NSData *data, NSError *error) {
        [self backPushed:nil];
    }];
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
