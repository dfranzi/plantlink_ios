//
//  PLAbstractViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

#import "PLUserManager.h"
#import "AbstractRequest.h"

@interface PLAbstractViewController() {
@private

}
@end

@implementation PLAbstractViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    sharedUser = [PLUserManager initializeUserManager];

    _nextSegueIdentifier = @"";
}

#pragma mark -
#pragma mark Getters

-(BOOL)isIphone5 {
    return [UIScreen mainScreen].bounds.size.height == 568;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)popView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)nextPushed:(id)sender {
    if([_nextSegueIdentifier isEqualToString:@""])return;
    
    [self performSegueWithIdentifier:_nextSegueIdentifier sender:self];
}

#pragma mark -
#pragma mark Request Methods

-(void)requestDidFail:(AbstractRequest *)request {
    ZALog(@"Request failed: %@",[request error]);
}

-(void)requestDidFinish:(AbstractRequest *)request {
    
}

@end
