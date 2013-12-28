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
    [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(popView:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
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
    if(userRequest) [userRequest cancel];
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
    offset += 20;
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
        else {
            [self adjustViewToNewResponder:nameTextField];
            [self nextPushed:nil];
        }
    }
    else {
        [textField resignFirstResponder];
        [self adjustViewToNewResponder:nameTextField];
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

#warning Confirm password not implemented
#warning Saved email could change during load
#warning No email saved after successful registration

-(void)loginRequest {
    if(userRequest) return;
    
    NSString *email = [emailTextField text];
    NSString *password = [passwordTextField text];
    
    userRequest = [[PLUserRequest alloc] init];
    [userRequest loginUserWithEmail:email andPassword:password withResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([dict isKindOfClass:[NSArray class]]) {
            if([self errorInRequestResponse:((NSArray*)dict)[0]]) {
                userRequest = NULL;
                return;
            }
        }
     
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[emailTextField text] forKey:Defaults_SavedEmail];
        
        [sharedUser setLastUsername:email andPassword:password];
        [super nextPushed:nil];
        userRequest = NULL;
    }];
}

-(void)registerRequest {
    NSMutableDictionary *setupDict = [NSMutableDictionary dictionary];
    
    NSString *name = [nameTextField text];
    NSString *email = [emailTextField text];
    NSString *password = [passwordTextField text];
    NSString *confirm = [confirmPasswordTextField text];
    
    if([name isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter a name" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([email isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter an email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![GeneralMethods validateEmailFormat:email]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter a valid email" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([password isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter a password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if([confirm isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please confirm your password" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if(![password isEqualToString:confirm]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please make sure your passwords match" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    setupDict[Constant_SetupDict_Name] = name;
    setupDict[Constant_SetupDict_Email] = email;
    setupDict[Constant_SetupDict_Password] = password;
    
    [sharedUser setSetupDict:setupDict];
    [super nextPushed:nil];
}

@end
