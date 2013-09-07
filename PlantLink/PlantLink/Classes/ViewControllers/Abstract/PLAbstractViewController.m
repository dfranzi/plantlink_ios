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

    [self.view setBackgroundColor:Color_ViewBackground];
    _nextSegueIdentifier = @"";
    
    [self setCustomNavBarDesign];
}

#pragma mark -
#pragma mark Display Methods


-(void)setCustomNavBarDesign {
    [self.navigationController.navigationBar setShadowImage:[GeneralMethods imageWithColor:SHADE_A(0.0, 0.0) andSize:CGSizeMake(1, 1)]];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:Color_NavBar_Background];
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                               UITextAttributeTextColor : [UIColor whiteColor],
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 0.0f)]
     }];
    
    UIImage *backButtonImage = [UIImage imageNamed:Image_Navigation_BackButton];
    [self.navigationItem.leftBarButtonItem setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

-(void)addLeftNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector {
    navItem.leftBarButtonItem = NULL;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)addRightNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector {
    navItem.rightBarButtonItem = NULL;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark -
#pragma mark Request Methods

-(void)requestDidFail:(AbstractRequest *)request {
    ZALog(@"Request failed: %@",[request error]);
}

-(void)requestDidFinish:(AbstractRequest *)request {
    
}

@end
