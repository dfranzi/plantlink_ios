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

@implementation PLSettingsAccountCell

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)resetPasswordPushed:(id)sender {
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    PLUserModel *user = [sharedUser user];
    
    passwordResetRequest = [[PLUserRequest alloc] init];
    [passwordResetRequest resetPasswordForEmail:[user email] withResponse:^(NSData *data, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password Reset" message:@"A reset link has been sent to your email account" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
}

-(IBAction)changeEmailPushed:(id)sender {
    NSString *email = newEmailTextField.text;
    NSString *password = confirmPasswordTextField.text;
    
    if([email isEqualToString:@""] || [password isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"A new email address and current password must be provided" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    PLUserModel *user = [sharedUser user];
    
    userUpdateRequest = [[PLUserRequest alloc] init];
    [userUpdateRequest updateUser:@{PostKey_Email : email, PostKey_Password : password} withResponse:^(NSData *data, NSError *error) {
        NSLog(@"Response: %@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]);
        #warning Not properly implemented
        
    }];
    
}

-(IBAction)closePushed:(id)sender {
    [[self parentViewController] closeSection:State_Account];
}

#pragma mark -
#pragma mark Override Methods

-(void)setStateDict:(NSDictionary *)stateDict {
    [super setStateDict:stateDict];
    NSLog(@"Set dict: %@",stateDict);
    
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

+(CGSize)sizeForContent:(NSDictionary*)content {
    if([content.allKeys containsObject:State_Account]) return CGSizeMake(295.0, 434.0);
    return CGSizeMake(295, 110);
}

@end
