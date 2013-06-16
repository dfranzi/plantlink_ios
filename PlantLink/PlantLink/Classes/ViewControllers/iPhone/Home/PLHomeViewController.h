//
//  PLHomeViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLHomeViewController : PLAbstractViewController <UITextFieldDelegate> {
    IBOutlet UITextField *usernameTextField;
    IBOutlet UITextField *passwordTextField;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)loginPushed:(id)sender;

@end
