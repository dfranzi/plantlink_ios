//
//  PLLoginViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLTextField;
@interface PLLoginViewController : PLAbstractViewController <UITextFieldDelegate> {
    IBOutlet PLTextField *emailTextField;
    IBOutlet PLTextField *passwordTextField;
    
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *forgotPasswordTextField;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)loginPushed:(id)sender;
-(IBAction)forgotPasswordPushed:(id)sender;

@end
