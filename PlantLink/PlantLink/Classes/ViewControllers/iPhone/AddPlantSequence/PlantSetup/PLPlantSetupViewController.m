//
//  PLPlantSetupViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantSetupViewController.h"

#import "PLPlantSetupOption.h"
#import "PLItemRequest.h"
#import "PLPlantTypeModel.h"
#import "PLSoilModel.h"
#import "PLUserManager.h"

#define State_PlantType @"plantTypeSelection"
#define State_SoilType @"soilTypeSelection"
#define State_Nickname @"nicknameSelection"

#define PossibleStates @{ @"0" : State_PlantType, @"1" : State_SoilType, @"2" : State_Nickname}

@interface PLPlantSetupViewController() {
@private
    UITableView *itemsTableView;
    
    NSArray *plantTypes;
    NSArray *soilTypes;
    NSString *state;
}

@end

@implementation PLPlantSetupViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    plantTypes = [sharedUser plantTypes];
    soilTypes = [sharedUser soilTypes];
    
    itemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 143, 320-2*30, 121)];
    [itemsTableView setDataSource:self];
    [itemsTableView setDelegate:self];
    [itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [itemsTableView setBackgroundColor:Color_ViewBackground];
    [itemsTableView setAlpha:0.0f];
    [self.view addSubview:itemsTableView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Actions 

-(void)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)nextPushed:(id)sender {
    [self performSegueWithIdentifier:Segue_ToConnectLink sender:self];
}

#pragma mark -
#pragma mark Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField.tag == 0) {
        [optionTwo.inputField becomeFirstResponder];
    }
    else if(textField.tag == 1) {
        [optionThree.inputField becomeFirstResponder];
    }
    else if(textField.tag == 2) {
        [self reset];
        [self nextPushed:nil];
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        NSString *key = [NSString stringWithFormat:@"%i",textField.tag];
        state = PossibleStates[key];
        [itemsTableView reloadData];
        
        textField.tag == 0 ? [optionOne setAlpha:1.0f] : [optionOne setAlpha:0.0f];
        textField.tag == 1 ? [optionTwo setAlpha:1.0f] : [optionTwo setAlpha:0.0f];
        textField.tag == 2 ? [optionThree setAlpha:1.0f] : [optionThree setAlpha:0.0f];
        
        [optionOne setCenter:CGPointMake(160, 120)];
        [optionTwo setCenter:CGPointMake(160, 120)];
        [optionThree setCenter:CGPointMake(160, 122)];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            if(textField.tag < 2) [itemsTableView setAlpha:1.0f];
            else [itemsTableView setAlpha:0.0f];
        }];
    }];
}

#pragma mark -
#pragma mark Display Methods

-(void)reset {
    [UIView animateWithDuration:0.3 animations:^{
        state = @"";
        
        [optionOne setAlpha:1.0f];
        [optionTwo setAlpha:1.0f];
        [optionThree setAlpha:1.0f];
        
        [optionOne setCenter:CGPointMake(160, 134)];
        [optionTwo setCenter:CGPointMake(160, 261)];
        [optionThree setCenter:CGPointMake(160, 406)];
        
        [itemsTableView setAlpha:0.0f];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([state isEqualToString:State_PlantType]) return [plantTypes count];
    else if([state isEqualToString:State_SoilType]) return [soilTypes count];
    else return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:tableView.backgroundColor];
    
    if([state isEqualToString:State_PlantType]) {
        PLPlantTypeModel *plant = plantTypes[indexPath.row];
        [[cell textLabel] setText:[plant name]];
    }
    else if([state isEqualToString:State_SoilType]) {
        PLSoilModel *soil = soilTypes[indexPath.row];
        [[cell textLabel] setText:[soil name]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([state isEqualToString:State_PlantType]) {
        PLPlantTypeModel *plant = plantTypes[indexPath.row];
        [optionOne.inputField setText:[plant name]];
    }
    else if([state isEqualToString:State_SoilType]) {
        PLSoilModel *soil = soilTypes[indexPath.row];
        [optionTwo.inputField setText:[soil name]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

@end
