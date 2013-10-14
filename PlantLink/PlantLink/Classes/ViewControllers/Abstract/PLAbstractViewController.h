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

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)popView:(id)sender;
-(IBAction)nextPushed:(id)sender;

#pragma mark -
#pragma mark Display Methods

-(void)addLeftNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector;
-(void)addRightNavButtonWithImageNamed:(NSString*)imageName toNavigationItem:(UINavigationItem*)navItem withSelector:(SEL)selector;

#pragma mark -
#pragma mark Request Methods

-(BOOL)errorInRequestResponse:(NSDictionary*)dict;

@end
