//
//  PLAbstractViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AbstractRequestProtocol.h"

@class PLUserManager;
@interface PLAbstractViewController : UIViewController <AbstractRequestDelegate> {
    PLUserManager *sharedUser;
}
@property(nonatomic, assign) BOOL isIphone5;
@property(nonatomic, strong) NSString *nextSegueIdentifier;

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)popView:(id)sender;
-(IBAction)nextPushed:(id)sender;

@end
