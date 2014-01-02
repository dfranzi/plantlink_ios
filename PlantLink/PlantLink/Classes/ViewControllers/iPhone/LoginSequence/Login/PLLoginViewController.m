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

/**
 * Loads the view setting the initial parameters to subview objects
 */
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

/**
 * Called every time the view appears, updated the view based on login type and shows the saved username if any
 */
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
        else [emailTextField setText:@""];
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

/**
 * Hides the navigation controller bar
 */
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

/**
 * Cancels the user request if any
 */
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(userRequest) [userRequest cancel];
}

#pragma mark -
#pragma mark IBAction Methods

/**
 * Segues to the next view depending on the type of login
 */
-(void)nextPushed:(id)sender {
    if([[sharedUser loginType] isEqual:Constant_LoginType_Login]) [self loginRequest];
    else [self registerRequest];
}

#pragma mark -
#pragma mark Display Methods

/**
 * Adjusts the text field location of a set of text fields and a given offset
 */
-(void)adjustTextFieldLocations:(NSArray*)fields offset:(int)offset {
    offset += 20;
    for(int i = 0; i < [fields count]; i++) {
        UITextField *field = fields[i];
        [field setCenter:CGPointMake(160, 80+i*48+offset)];
    }
}

/**
 * Adjusts the text views for the new responder, animating if necessary
 */
-(void)adjustViewToNewResponder:(UIView*)view {
    NSArray *fields = @[];
    if([[sharedUser loginType] isEqual:Constant_LoginType_Login]) fields = @[emailTextField,passwordTextField];
    else fields = @[nameTextField,emailTextField,passwordTextField,confirmPasswordTextField];
    
    int offset = 0;
    if([view isEqual:confirmPasswordTextField]) offset = -48;
    if([UIScreen mainScreen].bounds.size.height == 568) offset = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self adjustTextFieldLocations:fields offset:offset];
    }];
}



#pragma mark -
#pragma mark Text Field Methods

/**
 * Method called when a text field begins editting
 */
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [self adjustViewToNewResponder:textField];
}

/**
 * Adjusts the text field responders when the return key is pressed
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if([textField isEqual:nameTextField]) [emailTextField becomeFirstResponder];
    else if([textField isEqual:emailTextField]) [passwordTextField becomeFirstResponder];
    else if([textField isEqual:passwordTextField] && [[sharedUser loginType] isEqual:Constant_LoginType_Setup]) [confirmPasswordTextField becomeFirstResponder];
    else {
        [self adjustViewToNewResponder:nameTextField];
        [self nextPushed:nil];
    }
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

/**
 * Dismisses the keyboard is the user touches somewhere outside the text field views
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Request Methods

/**
 * Performs the login request, attempts to login the user and moving to the next view if successful
 */
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

/**
 * Performs the register request by validating the user input information and saving it if valid, moving to the next view
 */
-(void)registerRequest {
    NSMutableDictionary *setupDict = [NSMutableDictionary dictionary];
    
    NSString *name = [nameTextField text];
    NSString *email = [emailTextField text];
    NSString *password = [passwordTextField text];
    NSString *confirm = [confirmPasswordTextField text];

    if([self validName:name email:email password:password confirmation:confirm]) {
        setupDict[Constant_SetupDict_Name] = name;
        setupDict[Constant_SetupDict_Email] = email;
        setupDict[Constant_SetupDict_Password] = password;
        
        [sharedUser setSetupDict:setupDict];
        [super nextPushed:nil];
    }
}

#pragma mark -
#pragma mark Validation Methods

/**
 * Validates the given name, email, password, and password confirmation showing an error alert is something is wrong
 */
-(BOOL)validName:(NSString*)name email:(NSString*)email password:(NSString*)password confirmation:(NSString*)confirmation {
    NSString *alertMessage = @"";
    
    if([name isEqualToString:@""]) alertMessage = Error_Registration_NoName;
    else if([email isEqualToString:@""]) alertMessage = Error_Registration_NoEmail;
    else if(![GeneralMethods validateEmailFormat:email]) alertMessage = Error_Registration_InvalidEmail;
    else if([password isEqualToString:@""]) alertMessage = Error_Registration_NoPassword;
    else if([password length] < 8) alertMessage = Error_Registration_PasswordTooShort;
    else if([confirmation isEqualToString:@""]) alertMessage = Error_Registration_NoConfirmPassword;
    else if(![password isEqualToString:confirmation]) alertMessage = Error_Registration_NoPasswordMatch;
    
    if(![alertMessage isEqualToString:@""]) {
        [self displayErrorAlertWithMessage:alertMessage];
        return NO;
    }
    else return YES;
}

@end
