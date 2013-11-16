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
#import "PLItemRequest.h"
#import "PLPlantModel.h"
#import "PLSyncLinkViewController.h"

#define State_PlantType @"plantTypeSelection"
#define State_SoilType @"soilTypeSelection"
#define State_Nickname @"nicknameSelection"

#define PossibleStates @{ @"0" : State_PlantType, @"1" : State_SoilType, @"2" : State_Nickname}

@interface PLPlantSetupViewController() {
@private
    PLItemRequest *plantRequest;
    PLPlantModel *createdModel;
    UITableView *itemsTableView;
    
    NSArray *plantTypes;
    NSArray *soilTypes;
    NSString *state;
    
    NSMutableArray *drillDownPlants;
    NSMutableArray *drillDownSoils;
    
    NSString *plantTypeKey;
    NSString *soilTypeKey;
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
    
    int height = ([UIScreen mainScreen].bounds.size.height < 568) ? 480-79-64 : 568-79-64;
    itemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 79+64, 320-2*30, height)];
    [itemsTableView setDataSource:self];
    [itemsTableView setDelegate:self];
    [itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [itemsTableView setBackgroundColor:Color_ViewBackground];
    [self.view addSubview:itemsTableView];

    state = State_PlantType;
    [self update:[optionOne inputField].tag];

}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Actions 

-(void)backPushed:(id)sender {
    if([state isEqualToString:State_Nickname]) {
        state = State_SoilType;
        [self update:[optionTwo inputField].tag];
    }
    else if([state isEqualToString:State_SoilType]) {
        state = State_PlantType;
        [self update:[optionOne inputField].tag];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

-(void)nextPushed:(id)sender {
    NSString *plant = [optionThree.inputField text];
    NSString *type = [optionOne.inputField text];
    NSString *soil = [optionTwo.inputField text];
    
    if([state isEqualToString:State_PlantType]) {
        if([type isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter a plant type" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        BOOL contains = false;
        for(PLPlantTypeModel *model in plantTypes) {
            if([[[model name] lowercaseString] isEqualToString:[type lowercaseString]]) contains = true;
        }
        if(!contains) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"The plant type must match one from the list" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }

        state = State_SoilType;
        [self update:[optionTwo inputField].tag];
    }
    else if([state isEqualToString:State_SoilType]) {
        if([soil isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter a soil type" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        BOOL contains = false;
        for(PLSoilModel *model in soilTypes) {
            if([[[model name] lowercaseString] isEqualToString:[soil lowercaseString]]) contains = true;
        }
        if(!contains) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"The soil type must match one from the list" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        state = State_Nickname;
        [self update:[optionThree inputField].tag];
    }
    else {
        if([plant isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Please enter a nickname" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }

        ZALog(@"Plant type: %@ and soil type: %@",plantTypeKey,soilTypeKey);
        plantRequest = [[PLItemRequest alloc] init];
        [plantRequest addPlant:plant type:plantTypeKey inSoil:soilTypeKey withResponse:^(NSData *data, NSError *error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

            createdModel = [[PLPlantModel alloc] initWithDictionary:dict];
            [self performSegueWithIdentifier:Segue_ToSyncLink sender:self];
        }];
    }
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
    [textField resignFirstResponder];
    [self nextPushed:nil];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSString *key = [NSString stringWithFormat:@"%i",textField.tag];
    state = PossibleStates[key];
    [self update:textField.tag];
    
    [UIView animateWithDuration:0.3 animations:^{
       [itemsTableView setFrame:CGRectMake(30, 79+64, 320-2*30, [UIScreen mainScreen].bounds.size.height-79-64-216)];
    }];
}

-(void)update:(int)tag {
    [UIView animateWithDuration:0.3 animations:^{

        [itemsTableView reloadData];
        if([itemsTableView numberOfRowsInSection:0] > 0) [itemsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        tag == 0 ? [optionOne setAlpha:1.0f] : [optionOne setAlpha:0.0f];
        tag == 1 ? [optionTwo setAlpha:1.0f] : [optionTwo setAlpha:0.0f];
        tag == 2 ? [optionThree setAlpha:1.0f] : [optionThree setAlpha:0.0f];
        
        [optionOne setCenter:CGPointMake(160, 120)];
        [optionTwo setCenter:CGPointMake(160, 120)];
        [optionThree setCenter:CGPointMake(160, 120)];
        
        if([state isEqualToString:State_Nickname]) [itemsTableView setAlpha:0.0f];
        else [itemsTableView setAlpha:1.0f];
        
        NSString *imageName = Image_Navigation_BackButton;
        if([state isEqualToString:State_PlantType]) imageName = Image_Navigation_DismissButton;
        [self addLeftNavButtonWithImageNamed:imageName toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];

        UIButton *button = (UIButton*)self.navigationItem.leftBarButtonItem.customView;
        [UIView animateWithDuration:0.3 animations:^{
            [button setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [UIView animateWithDuration:0.3 animations:^{
                [button setAlpha:1.0f];
            }];
        }];
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            //if(textField.tag < 2) [itemsTableView setAlpha:1.0f];
            //else [itemsTableView setAlpha:0.0f];
        }];
    }];
}

#pragma mark -
#pragma mark Display Methods

-(void)reset {
    [UIView animateWithDuration:0.3 animations:^{
        int height = ([UIScreen mainScreen].bounds.size.height < 568) ? 480-79-64 : 568-79-64;
        [itemsTableView setFrame:CGRectMake(30, 79+64, 320-2*30, height)];
    }];
    
    return;
    //Not used
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
        plantTypeKey = [plant key];
    }
    else if([state isEqualToString:State_SoilType]) {
        NSArray *soils = soilTypes;
        if([drillDownSoils count] > 0) soils = [drillDownSoils lastObject];
        
        PLSoilModel *soil = soils[indexPath.row];
        [optionTwo.inputField setText:[soil name]];
        soilTypeKey = [soil key];
    }
    ZALog(@"Plant type: %@ and soil type: %@",plantTypeKey,soilTypeKey);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark -
#pragma mark Prepare For Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:Segue_ToSyncLink]) {
        PLSyncLinkViewController *destination = [segue destinationViewController];
        [destination setCreatedPlant:createdModel];
    }
}

@end
