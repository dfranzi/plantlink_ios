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

    [self.view setBackgroundColor:Color_ViewBackground];
    _nextSegueIdentifier = @"";
}

#pragma mark -
#pragma mark Display Methods

-(void)addLeftNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector {
    navItem.leftBarButtonItem = NULL;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [backButton setContentMode:UIViewContentModeLeft];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)addRightNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector {
    navItem.rightBarButtonItem = NULL;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [backButton setContentMode:UIViewContentModeRight];
    navItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
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

@end
