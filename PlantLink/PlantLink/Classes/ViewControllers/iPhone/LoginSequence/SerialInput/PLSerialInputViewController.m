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

@interface PLSerialInputViewController() {
@private
}

@end

@implementation PLSerialInputViewController

/**
 * Loads the initial parameters for the view and the subivews
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToLocationInput];
    [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(popView:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    [self.navigationItem setTitle:@"Serial Number"];
    [serialTextField setTitle:@"Serial #"];
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
    NSString *serial = serialTextField.text;

    if([serial isEqualToString:@""]) {
        [self displayErrorAlertWithMessage:Error_Registration_NoSerial];
        return;
    }
    
    [[sharedUser setupDict] setObject:serial forKey:Constant_SetupDict_SerialNumber];
    [super nextPushed:sender];
}

@end
