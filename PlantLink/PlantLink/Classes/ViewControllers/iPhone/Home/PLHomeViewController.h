//
//  PLHomeViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/9/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"


@interface PLHomeViewController : PLAbstractViewController <UIAlertViewDelegate>

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)setupPushed:(id)sender;
-(IBAction)loginPushed:(id)sender;

@end
