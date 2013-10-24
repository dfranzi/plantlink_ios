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
    
    NSMutableArray *drillDownPlants;
    NSMutableArray *drillDownSoils;
}

@end

@implementation PLPlantSetupViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    plantTypes = [sharedUser plantTypes];
    soilTypes = [sharedUser soilTypes];
    
    drillDownPlants = [NSMutableArray array];
    drillDownSoils = [NSMutableArray array];
    
    int height = ([UIScreen mainScreen].bounds.size.height < 568) ? 101 : 208;
    itemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 144, 320-2*30, height)];
    [itemsTableView setDataSource:self];
    [itemsTableView setDelegate:self];
    [itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [itemsTableView setBackgroundColor:Color_ViewBackground];
    [itemsTableView setAlpha:0.0f];
    [self.view addSubview:itemsTableView];
    [self reset];
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
    [self performSegueWithIdentifier:Segue_ToSyncLink sender:self];
}

#pragma mark -
#pragma mark Text Field Methods

-(IBAction)valueChanged:(id)sender {
    UITextField *textField = (UITextField*)sender;
    if(textField.tag == 0) {
        NSString *text = textField.text;
        ZALog(@"Here with: %@",text);
        if([text length] > [drillDownPlants count]) {
            ZALog(@"Too long");
            NSArray *last = [drillDownPlants lastObject];
            if([drillDownPlants count] == 0) last = plantTypes;
            NSMutableArray *new = [self prefixFilter:text fromPlants:last];
            [drillDownPlants addObject:new];
        }
        else if([text length] == [drillDownPlants count]-1) {
            [drillDownPlants removeLastObject];
        }
    }
    else if(textField.tag == 1) {
        NSString *text = textField.text;
        if([text length] > [drillDownSoils count]) {
            NSArray *last = [drillDownSoils lastObject];
            if([drillDownSoils count] == 0) last = soilTypes;
            NSMutableArray *new = [self prefixFilter:text fromSoils:last];
            [drillDownSoils addObject:new];
        }
        else if([text length] < [drillDownPlants count]) {
            [drillDownSoils removeLastObject];
        }
    }
    [itemsTableView reloadData];
}

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
        if([itemsTableView numberOfRowsInSection:0] > 0) [itemsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
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
    [self reset];
}

#pragma mark -
#pragma mark Content Methods

-(NSMutableArray*)prefixFilter:(NSString*)prefix fromPlants:(NSArray*)plants {
    NSMutableArray *retArr = [NSMutableArray array];
    for(PLPlantTypeModel *plant in plants) {
        ZALog(@"Looking for: %@ in %@",prefix,[plant name]);
        if([[[plant name] lowercaseString] rangeOfString:[prefix lowercaseString]].location != NSNotFound) {
            ZALog(@"    Found");
            [retArr addObject:plant];
        }
    }
    return retArr;
}

-(NSMutableArray*)prefixFilter:(NSString*)prefix fromSoils:(NSArray*)soils {
    NSMutableArray *retArr = [NSMutableArray array];
    for(PLSoilModel *soil in soils) {
        if([[[soil name] lowercaseString] rangeOfString:[prefix lowercaseString]].location != NSNotFound) [retArr addObject:soil];
    }
    return retArr;
}

#pragma mark -
#pragma mark TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([state isEqualToString:State_PlantType]) {
        if([drillDownPlants count] > 0) return [[drillDownPlants lastObject] count];
        return [plantTypes count];
    }
    else if([state isEqualToString:State_SoilType]) {
        if([drillDownSoils count] > 0) return [[drillDownSoils lastObject] count];
        return [soilTypes count];
    }
    else return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell setBackgroundColor:tableView.backgroundColor];
    
    if([state isEqualToString:State_PlantType]) {
        NSArray *plants = plantTypes;
        if([drillDownPlants count] > 0) plants = [drillDownPlants lastObject];
        
        PLPlantTypeModel *plant = plants[indexPath.row];
        [[cell textLabel] setText:[plant name]];
    }
    else if([state isEqualToString:State_SoilType]) {
        NSArray *soils = soilTypes;
        if([drillDownSoils count] > 0) soils = [drillDownSoils lastObject];
        
        PLSoilModel *soil = soils[indexPath.row];
        [[cell textLabel] setText:[soil name]];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([state isEqualToString:State_PlantType]) {
        NSArray *plants = plantTypes;
        if([drillDownPlants count] > 0) plants = [drillDownPlants lastObject];
        
        PLPlantTypeModel *plant = plants[indexPath.row];
        [optionOne.inputField setText:[plant name]];
    }
    else if([state isEqualToString:State_SoilType]) {
        NSArray *soils = soilTypes;
        if([drillDownSoils count] > 0) soils = [drillDownSoils lastObject];
        
        PLSoilModel *soil = soils[indexPath.row];
        [optionTwo.inputField setText:[soil name]];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

@end
