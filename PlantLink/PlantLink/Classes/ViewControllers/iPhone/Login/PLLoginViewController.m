//
//  PLLoginViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLoginViewController.h"

#import "PLTextField.h"
#import "PLUserRequest.h"

@interface PLLoginViewController() {
@private
    PLUserRequest *loginRequest;
    PLUserRequest *forgotPasswordRequest;
}

@end

@implementation PLLoginViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [emailTextField setLeftLabel:@"Email"];
    [passwordTextField setLeftLabel:@"Password"];

    [forgotPasswordTextField setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [forgotPasswordTextField setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [loginRequest cancelRequest];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)loginPushed:(id)sender {
    BOOL validEmail = [emailTextField validate:Validation_Email];
    BOOL validPassword = [passwordTextField validate:Validation_Empty];
    BOOL validParameters = validEmail && validPassword;
    if(!validParameters) return;
    
    NSString *email = [emailTextField text];
    NSString *password = [passwordTextField text];
    
    loginRequest = [[PLUserRequest alloc] initLoginUserRequestWithEmail:email andPassword:password];
    [loginRequest setDelegate:self];
    [loginRequest startRequest];
}

-(IBAction)forgotPasswordPushed:(id)sender {
    BOOL validEmail = [emailTextField validate:Validation_Email];
    if(!validEmail) return;
    
    NSString *email = [emailTextField text];
    forgotPasswordRequest = [[PLUserRequest alloc] initPasswordResetRequestWithEmail:email];
    [forgotPasswordRequest setDelegate:self];
    [forgotPasswordRequest startRequest];
}

#pragma mark -
#pragma mark Request Methods

-(void)requestDidFinish:(AbstractRequest *)request {
    if([request type] == Request_LoginUser && [request successful]) {
        NSString *jsonStr = [[NSString alloc] initWithData:[request data] encoding:NSUTF8StringEncoding];
        ZALog(@"Login response: %@",jsonStr);
        
        [self performSegueWithIdentifier:Segue_ToMyGarden sender:self];
    }
}

#pragma mark -
#pragma mark Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([textField isEqual:emailTextField]) {
        [emailTextField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
    }
    else if([textField isEqual:passwordTextField]) {
        [passwordTextField resignFirstResponder];
        [self loginPushed:nil];
    }
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
