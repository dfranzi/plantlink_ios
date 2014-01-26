//
//  PLAbstractViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

#import "PLUserManager.h"
#import "TestFlight.h"

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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[GeneralMethods imageWithColor:Color_PlantLinkGreen andSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) {
        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    }
}

-(void)setTabBarIconActive:(NSString*)imageNameActive passive:(NSString*)imageNamePassive {
    UIImage *active = [UIImage imageNamed:imageNameActive];
    UIImage *passive = [UIImage imageNamed:imageNamePassive];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:active withFinishedUnselectedImage:passive];

}

#pragma mark -
#pragma mark Display Methods

-(void)addLeftNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector {
    navItem.leftBarButtonItem = NULL;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0000) [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
}

-(void)addRightNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector {
    navItem.rightBarButtonItem = NULL;
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [backButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [backButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0000) [backButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
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

-(BOOL)errorInRequestResponse:(NSDictionary*)dict {
    if([dict.allKeys containsObject:@"severity"] && [dict[@"severity"] isEqualToString:@"Error"]) {
        NSString *errorKey = dict[@"type_detail"];
        NSString *message = dict[@"message"];
        if([Error_Dict.allKeys containsObject:errorKey]) message = Error_Dict[errorKey];
        else {
            if([dict.allKeys containsObject:@"type"] && [dict.allKeys containsObject:@"type_detail"]) TFLog(@"Generic error occured on: (%@, %@) %@",dict[@"type"],dict[@"severity"],dict[@"type_detail"]);
        }
        
        [self displayErrorAlertWithMessage:message];
        return YES;
    }
    return NO;
}

-(void)displayErrorAlertWithMessage:(NSString*)errorMessage {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh oh" message:errorMessage delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

@end
