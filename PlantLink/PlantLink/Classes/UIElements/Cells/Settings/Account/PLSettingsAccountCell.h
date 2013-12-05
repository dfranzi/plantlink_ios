//
//  PLSettingsAccountCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 11/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsCell.h"

@interface PLSettingsAccountCell : PLSettingsCell {
    IBOutlet UITextField *newEmailTextField;
    IBOutlet UITextField *confirmPasswordTextField;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)resetPasswordPushed:(id)sender;
-(IBAction)changeEmailPushed:(id)sender;
-(IBAction)closePushed:(id)sender;

@end
