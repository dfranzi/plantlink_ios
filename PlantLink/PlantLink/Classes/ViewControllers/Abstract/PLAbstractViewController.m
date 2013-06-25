//
//  PLAbstractViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"
#import "PLUserManager.h"

@interface PLAbstractViewController() {
@private

}
@end

@implementation PLAbstractViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    sharedUser = [PLUserManager initializeUserManager];
    
    [self.navigationController.navigationBar setBackgroundColor:Color_OsoGreen];
    [self.navigationController.navigationBar setTintColor:Color_OsoGreen];
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

@end
