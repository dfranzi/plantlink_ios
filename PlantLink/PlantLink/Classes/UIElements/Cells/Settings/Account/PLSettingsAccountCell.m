//
//  PLSettingsAccountCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 11/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsAccountCell.h"
#import "PLSettingsViewController.h"

#import "PLUserManager.h"
#import "PLUserModel.h"
#import "PLUserRequest.h"

@interface PLSettingsAccountCell () {
    PLUserRequest *passwordResetRequest;
    PLUserRequest *userUpdateRequest;
}

@end

#define Alert_PasswordResetTitle @"Success"
#define Alert_PasswordResetMessage @"An email has been sent to you with instructions to reset your password."

#define Alert_EmailChangeTitle @"Success"
#define Alert_EmailChangeMessage @"Your email was changed successfully."

#define Alert_ErrorTitle @"Uh oh"
#define Alert_NoNewEmail @"Please enter a new email."
#define Alert_InvalidEmail @"Please enter a valid new email."
#define Alert_NoPassword @"Please enter your current password."

@implementation PLSettingsAccountCell

#pragma mark -
#pragma mark IBAction Methods

/**
 * Called when the reset password button is pushed, and attempts to reset the password showing alerts where necessary
 */
-(IBAction)resetPasswordPushed:(id)sender {
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    PLUserModel *user = [sharedUser user];
    
    passwordResetRequest = [[PLUserRequest alloc] init];
    [passwordResetRequest resetPasswordForEmail:[user email] withResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if([dict isKindOfClass:[NSArray class]]) {
            if([self errorInRequestResponse:((NSArray*)dict)[0]]) {}
        }
        else {
            [self displayAlertWithTitle:Alert_PasswordResetTitle andMessage:Alert_PasswordResetMessage];
        }
    }];
}

/**
 * Called when the change email button is pushed, and attempts to change the email shows alerts where necessary
 */
-(IBAction)changeEmailPushed:(id)sender {
    NSString *email = newEmailTextField.text;
    NSString *password = confirmPasswordTextField.text;
    
    if([email isEqualToString:@""]) [self displayAlertWithTitle:Alert_ErrorTitle andMessage:Alert_NoNewEmail];
    else if([password isEqualToString:@""]) [self displayAlertWithTitle:Alert_ErrorTitle andMessage:Alert_NoPassword];
    else if(![GeneralMethods validateEmailFormat:email]) [self displayAlertWithTitle:Alert_ErrorTitle andMessage:Alert_InvalidEmail];
    else {
        userUpdateRequest = [[PLUserRequest alloc] init];
        [userUpdateRequest updateUser:@{PostKey_Email : email, PostKey_Password : password} withResponse:^(NSData *data, NSError *error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if([dict isKindOfClass:[NSArray class]]) {
                if([self errorInRequestResponse:((NSArray*)dict)[0]]) {}
            }
            else {
                [self displayAlertWithTitle:Alert_EmailChangeTitle andMessage:Alert_EmailChangeMessage];
                
                PLUserManager *sharedUser = [PLUserManager initializeUserManager];
                [sharedUser refreshData];
            }
        }];
    }
}

/**
 * Called when the close button is pushed, closes the cell by updating the parent view controller
 */
-(IBAction)closePushed:(id)sender {
    [[self parentViewController] closeSection:State_Account];
}

#pragma mark -
#pragma mark Override Methods

/**
 * Prevents the push down animation from happening if the cell is expanded
 */
-(void)setHighlighted:(BOOL)highlighted {
    if(![[self stateDict].allKeys containsObject:State_Account]) [super setHighlighted:highlighted];
}

/**
 * When the state dict is updated this method animates the expansion or compression of the cell
 */
-(void)setStateDict:(NSDictionary *)stateDict {
    [super setStateDict:stateDict];

    if([stateDict.allKeys containsObject:State_Account]) {
        [UIView animateWithDuration:0.3 animations:^{
            CGSize size = [PLSettingsAccountCell sizeForContent:stateDict];
            [background setFrame:CGRectMake(0, 0, size.width, size.height-2)];
            [backdrop setFrame:CGRectMake(0, 0, size.width, size.height+1)];
        } completion:^(BOOL finished) {}];
    }
    else {
        CGSize size = [PLSettingsAccountCell sizeForContent:stateDict];
        [UIView animateWithDuration:0.3 animations:^{
            [background setFrame:CGRectMake(0, 0, size.width, size.height-2)];
            [backdrop setFrame:CGRectMake(0, 0, size.width, size.height+1)];
        }];
    }
    
    self.contentView.bounds = CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.frame.size.width, self.frame.size.height);
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the hieght for the cell in expanded and compressed modes, depending on the input content dict
 */
+(CGSize)sizeForContent:(NSDictionary*)content {
    if([content.allKeys containsObject:State_Account]) return CGSizeMake(295.0, 434.0);
    return CGSizeMake(295, 110);
}

@end
