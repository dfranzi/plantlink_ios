//
//  PLRegisterViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLTextField;
@interface PLRegisterViewController : PLAbstractViewController <UITextFieldDelegate> {
    IBOutlet PLTextField *nameTextField;
    IBOutlet PLTextField *emailTextField;
    IBOutlet PLTextField *passwordTextField;
    IBOutlet PLTextField *locationTextField;
    IBOutlet PLTextField *serialNumberTextField;
    
    IBOutlet UIButton *registerButton;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)registerPushed:(id)sender;

@end
