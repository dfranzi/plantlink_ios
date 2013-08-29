//
//  PLNotificationViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLNotificationOptionButton;
@interface PLNotificationViewController : PLAbstractViewController {
    IBOutlet PLNotificationOptionButton *morningButton;
    IBOutlet PLNotificationOptionButton *noonButton;
    IBOutlet PLNotificationOptionButton *eveningButton;
    IBOutlet PLNotificationOptionButton *midnightButton;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender;
-(IBAction)savePushed:(id)sender;

-(IBAction)morningPushed:(id)sender;
-(IBAction)noonPushed:(id)sender;
-(IBAction)eveningPushed:(id)sender;
-(IBAction)midnightPushed:(id)sender;

@end
