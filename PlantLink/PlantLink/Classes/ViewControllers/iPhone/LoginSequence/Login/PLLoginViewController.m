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
    
    [self.navigationItem setTitle:@"Account Info"];

    [nameTextField setTitle:@"Name"];
    [emailTextField setTitle:@"Email"];
    [passwordTextField setTitle:@"Password"];
    [confirmPasswordTextField setTitle:@"Confirm"];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    userRequest = NULL;
    
    if([[sharedUser loginType] isEqualToString:Constant_LoginType_Login]) {
        [self setNextSegueIdentifier:Segue_ToUserHome];
        [confirmPasswordTextField setAlpha:0.0f];
        [nameTextField setAlpha:0.0f];
        [passwordTextField setReturnKeyType:UIReturnKeyGo];
        [disclaimerTextField setAlpha:0.0];
        
        [self adjustTextFieldLocations:@[emailTextField,passwordTextField] offset:0];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *savedEmail = [defaults objectForKey:Defaults_SavedEmail];
        if(savedEmail) [emailTextField setText:savedEmail];
    }
    else {
        [self setNextSegueIdentifier:Segue_ToSerialInput];
        [confirmPasswordTextField setAlpha:1.0f];
        [nameTextField setAlpha:1.0f];
        [passwordTextField setReturnKeyType:UIReturnKeyNext];
        
        [self adjustTextFieldLocations:@[nameTextField,emailTextField,passwordTextField,confirmPasswordTextField] offset:0];
        
        [disclaimerTextField setAlpha:1.0];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
#pragma mark Display Methods

-(void)adjustTextFieldLocations:(NSArray*)fields offset:(int)offset {
    for(int i = 0; i < [fields count]; i++) {
        UITextField *field = fields[i];
        [field setCenter:CGPointMake(160, 80+i*48+offset)];
    }
}

-(void)adjustViewToNewResponder:(UIView*)view {
    
    NSArray *fields = @[];
    if([[sharedUser loginType] isEqual:Constant_LoginType_Login]) fields = @[emailTextField,passwordTextField];
    else fields = @[nameTextField,emailTextField,passwordTextField,confirmPasswordTextField];
    
    if([view isEqual:confirmPasswordTextField]) {
        [UIView animateWithDuration:0.3 animations:^{
            [self adjustTextFieldLocations:fields offset:-48];
        }];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            [self adjustTextFieldLocations:fields offset:0];
        }];
    }
}



#pragma mark -
#pragma mark Text Field Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self adjustViewToNewResponder:textField];
}

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
    #warning Login does not account for incorrect credentials
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[request data] options:NSJSONReadingMutableLeaves error:nil];
    ZALog(@"Dict: %@",dict);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[emailTextField text] forKey:Defaults_SavedEmail];
    
    [super nextPushed:nil];
}

@end
