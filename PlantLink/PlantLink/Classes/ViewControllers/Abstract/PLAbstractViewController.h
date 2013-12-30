//
//  PLAbstractViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLUserManager;
@interface PLAbstractViewController : UIViewController {
    PLUserManager *sharedUser;
}
@property(nonatomic, assign) BOOL isIphone5;
@property(nonatomic, strong) NSString *nextSegueIdentifier;

/**
 * Sets the tab bar selected and unselected image
 */
-(void)setTabBarIconActive:(NSString*)imageNameActive passive:(NSString*)imageNamePassive;

#pragma mark -
#pragma mark IBAction Methods

/**
 * Assign/call this action to anything that would cause the view to be popped from the navigation stack
 */
-(IBAction)popView:(id)sender;

/**
 * Assign/call this action to anything that would cause a segue with the name specified by 'nextSegueIdentifier' to be taken
 */
-(IBAction)nextPushed:(id)sender;

#pragma mark -
#pragma mark Display Methods

/**
 * Adds a left navigation button with the specified image and given selector
 */
-(void)addLeftNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector;

/**
 * Adds a right navigation button with the specified image and given selector
 */
-(void)addRightNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector;

#pragma mark -
#pragma mark Request Methods

/**
 * Returns a boolean if there is an error in the request and displays an alert with the error if there is one
 */
-(BOOL)errorInRequestResponse:(NSDictionary*)dict;

/**
 * Displays an alert with the message given
 */
-(void)displayErrorAlertWithMessage:(NSString*)errorMessage;

@end
