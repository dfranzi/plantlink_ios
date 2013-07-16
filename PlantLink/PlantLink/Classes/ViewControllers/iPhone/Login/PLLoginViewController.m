//
//  PLLoginViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLoginViewController.h"

#import "PLTextField.h"
#import "PLUserRequest.h"

@interface PLLoginViewController() {
@private
    PLUserRequest *userRequest;
}

@end

@implementation PLLoginViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToSerialInput];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    userRequest = NULL;
    
    if([[sharedUser loginType] isEqualToString:Constant_LoginType_Login]) {
        [self setNextSegueIdentifier:Segue_ToUserHome];
        [confirmPasswordTextField setAlpha:0.0f];
        [nameTextField setAlpha:0.0f];
        [passwordTextField setReturnKeyType:UIReturnKeyGo];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *savedEmail = [defaults objectForKey:Defaults_SavedEmail];
        if(savedEmail) [emailTextField setText:savedEmail];
    }
    else {
        [self setNextSegueIdentifier:Segue_ToSerialInput];
        [confirmPasswordTextField setAlpha:1.0f];
        [nameTextField setAlpha:1.0f];
        [passwordTextField setReturnKeyType:UIReturnKeyNext];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(userRequest) [userRequest cancelRequest];
}

#pragma mark -
#pragma mark IBAction Methods

-(void)nextPushed:(id)sender {
    if([[sharedUser loginType] isEqual:Constant_LoginType_Login]) [self loginRequest];
    else [self registerRequest];
}

#pragma mark -
#pragma mark Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([textField isEqual:nameTextField]) {
        [nameTextField resignFirstResponder];
        [emailTextField becomeFirstResponder];
    }
    else if([textField isEqual:emailTextField]) {
        [emailTextField resignFirstResponder];
        [passwordTextField becomeFirstResponder];
    }
    else if([textField isEqual:passwordTextField]) {
        [passwordTextField resignFirstResponder];
        if([[sharedUser loginType] isEqual:Constant_LoginType_Setup]) [confirmPasswordTextField becomeFirstResponder];
        else [self nextPushed:nil];
    }
    else {
        [textField resignFirstResponder];
        [self nextPushed:nil];
    
    }
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Request Methods

#warning Validation Not Completed
#warning Confirm password not implemented
#warning Saved email could change during load
#warning No email saved after successful registration

-(void)loginRequest {
    NSString *email = [emailTextField text];
    NSString *password = [passwordTextField text];
    
    userRequest = [[PLUserRequest alloc] initLoginUserRequestWithEmail:email andPassword:password];
    [userRequest setDelegate:self];
    [userRequest startRequest];
}

-(void)registerRequest {
    NSMutableDictionary *setupDict = [NSMutableDictionary dictionary];
    
    NSString *name = [nameTextField text];
    NSString *email = [emailTextField text];
    NSString *password = [passwordTextField text];
    
    setupDict[Constant_SetupDict_Name] = name;
    setupDict[Constant_SetupDict_Email] = email;
    setupDict[Constant_SetupDict_Password] = password;
    
    [sharedUser setSetupDict:setupDict];
    [super nextPushed:nil];
}

-(void)requestDidFinish:(AbstractRequest *)request {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[request data] options:NSJSONReadingMutableLeaves error:nil];
    ZALog(@"Dict: %@",dict);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[emailTextField text] forKey:Defaults_SavedEmail];
    
    [super nextPushed:nil];
}

@end
