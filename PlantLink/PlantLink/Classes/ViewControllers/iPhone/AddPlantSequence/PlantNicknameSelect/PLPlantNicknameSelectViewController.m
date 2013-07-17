//
//  PLPlantNicknameSelectViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantNicknameSelectViewController.h"

@interface PLPlantNicknameSelectViewController() {
@private
}

@end

@implementation PLPlantNicknameSelectViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToBaseStationSync];
}

#pragma mark -
#pragma mark Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if([textField isEqual:nicknameTextField]) [self.view endEditing:YES];
    return YES;
}

#pragma mark -
#pragma mark Touch Method

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
