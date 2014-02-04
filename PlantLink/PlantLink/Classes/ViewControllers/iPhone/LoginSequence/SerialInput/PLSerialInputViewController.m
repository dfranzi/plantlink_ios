//
//  PLSerialInputViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSerialInputViewController.h"

#import "PLTextField.h"
#import "PLUserManager.h"
#import "PLUserRequest.h"

@interface PLSerialInputViewController() {
@private
    PLUserRequest *stationRequest;
    
}

@end

@implementation PLSerialInputViewController

/**
 * Loads the initial parameters for the view and the subivews
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToAddFirstPlant];
    [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(popView:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    [self.navigationItem setTitle:@"Serial Number"];
    [serialTextField setTitle:@"Serial #"];
    serialTextField.placeholder = @"####-####-####";
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark Text Field Methods

/**
 * Dismisses the keyboard upon clicking return and attempts to move to the next view
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self nextPushed:nil];
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

/**
 * Dismisses the keyboard if the view is touched outside of the text field
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Next Methods

/**
 * Transitions to the next view if the serial is non-empty, otherwise shows an error alert
 */
-(void)nextPushed:(id)sender {
    if(stationRequest) return;
    
    NSString *serial = serialTextField.text;
    serial = [serial stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if([serial isEqualToString:@""]) {
        [self displayErrorAlertWithMessage:Error_Registration_NoSerial];
        return;
    }
    else if([serial length] != 12) {
        [self displayErrorAlertWithMessage:Error_Registration_IncorrectSerial];
        return;
    }
    
    stationRequest = [[PLUserRequest alloc] init];
    [stationRequest updateUser:@{PostKey_BaseStationSerial : @[serial]} withResponse:^(NSData *data, NSError *error) {
        if(error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"uh oh" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            stationRequest = NULL;
            return;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if([dict isKindOfClass:[NSArray class]]) {
            if([self errorInRequestResponse:((NSArray*)dict)[0]]) {
                stationRequest = NULL;
                return;
            }
        }
        
        [sharedUser refreshUserData];
        stationRequest = NULL;
        [super nextPushed:sender];
        
    }];
}

@end
