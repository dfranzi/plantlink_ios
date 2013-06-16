//
//  PLHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLHomeViewController.h"

#import "AbstractRequest.h"
#import "PLUserRequest.h"

@interface PLHomeViewController() {
@private
    PLUserRequest *userRequest;
    BOOL next;
}
@end

@implementation PLHomeViewController

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)loginPushed:(id)sender {
    NSString *username = usernameTextField.text;
    NSString *password = passwordTextField.text;
    
    userRequest = [[PLUserRequest alloc] initLoginUserRequestWithEmail:username andPassword:password];
    [userRequest setDelegate:self];
    [userRequest startRequest];
}

#pragma mark -
#pragma mark Request Methods

-(void)requestDidFinish:(AbstractRequest *)request {
    if([request successful]) {
        ZALog(@"Data: %@",[[NSString alloc] initWithData:[request data] encoding:NSUTF8StringEncoding]);
        [self performSegueWithIdentifier:Segue_ToMyGarden sender:self];
    }
}

#pragma mark -
#pragma mark TextField Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
