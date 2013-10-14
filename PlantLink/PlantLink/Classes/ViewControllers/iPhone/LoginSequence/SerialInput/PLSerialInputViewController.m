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

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self nextPushed:nil];
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Next Methods

-(void)nextPushed:(id)sender {
    NSString *serial = serialTextField.text;
    
    if([serial isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter a serial number" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [[sharedUser setupDict] setObject:serial forKey:Constant_SetupDict_SerialNumber];
    [super nextPushed:sender];
}

@end
