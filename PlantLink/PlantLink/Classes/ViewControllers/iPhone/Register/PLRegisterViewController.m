//
//  PLRegisterViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLRegisterViewController.h"

#import "PLTextField.h"
#import "PLUserRequest.h"

@interface PLRegisterViewController() {
@private
    PLUserRequest *registerRequest;
    
    CGPoint originalCenter;
}

@end

@implementation PLRegisterViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [nameTextField setLeftLabel:@"Name"];
    [emailTextField setLeftLabel:@"Email"];
    [passwordTextField setLeftLabel:@"Password"];
    [locationTextField setLeftLabel:@"Location"];
    [serialNumberTextField setLeftLabel:@"Serial #"];
    [serialNumberTextField setRightInfoWithTitle:@"Base Station Serial #" text:@"To register an account, please include the serial number of the base station you have purchased" andCancelButton:@"Ok"];
    
    originalCenter = self.view.center;
    originalCenter.y -= 44;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [registerRequest cancelRequest];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)registerPushed:(id)sender {
    NSString *name = [nameTextField text];
    NSString *email = [emailTextField text];
    NSString *password = [passwordTextField text];
    NSString *location = [locationTextField text];
    NSString *serial = [serialNumberTextField text];
    
    registerRequest = [[PLUserRequest alloc] initRegisterUserRequestWithEmail:email name:name password:password andZipCode:location andBaseStationSerial:serial];
    [registerRequest setDelegate:self];
    [registerRequest startRequest];
}

#pragma mark -
#pragma mark Request Methods

-(void)requestDidFinish:(AbstractRequest *)request {
    if([request type] == Request_RegisterUser && [request successful]) {
        NSString *jsonStr = [[NSString alloc] initWithData:[request data] encoding:NSUTF8StringEncoding];
        ZALog(@"Login response: %@",jsonStr);
        
        [self performSegueWithIdentifier:Segue_ToMyGarden sender:self];
    }
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
        [locationTextField becomeFirstResponder];
    }
    else if([textField isEqual:locationTextField]) {
        [locationTextField resignFirstResponder];
        [serialNumberTextField becomeFirstResponder];
    }
    else if([textField isEqual:serialNumberTextField]) {
        [serialNumberTextField resignFirstResponder];
        [self registerPushed:nil];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if([textField isEqual:passwordTextField]) [self animateToView:passwordTextField];
    else if([textField isEqual:locationTextField]) [self animateToView:locationTextField];
    else if([textField isEqual:serialNumberTextField]) [self animateToView:serialNumberTextField];
}

-(void)animateToView:(UIView*)view {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        CGRect screenSize = [UIScreen mainScreen].bounds;
        int yLoc = view.center.y - 150;
        [self.view setCenter:CGPointMake(screenSize.size.width / 2, self.view.center.y - yLoc)];
    } completion:^(BOOL finished) {}];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [self.view setCenter:originalCenter];
    } completion:^(BOOL finished) {}];
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Keyboard Methods



@end
