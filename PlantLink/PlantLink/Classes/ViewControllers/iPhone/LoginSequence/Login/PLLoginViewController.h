//
//  PLLoginViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

#import "PLUserManager.h"

@class PLTextField;
@interface PLLoginViewController : PLAbstractViewController <UITextFieldDelegate> {
    IBOutlet PLTextField *nameTextField;
    IBOutlet PLTextField *emailTextField;
    IBOutlet PLTextField *passwordTextField;
    IBOutlet PLTextField *confirmPasswordTextField;
    IBOutlet UILabel *disclaimerTextField;
}

#pragma mark -
#pragma mark Action Methods

-(IBAction)termsPushed:(id)sender;
-(IBAction)privacyPushed:(id)sender;

@end
