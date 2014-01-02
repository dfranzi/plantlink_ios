//
//  PLPlantSetupViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantSetupViewController.h"

#import "PLItemRequest.h"
#import "PLPlantTypeModel.h"
#import "PLSoilModel.h"
#import "PLUserManager.h"
#import "PLItemRequest.h"
#import "PLPlantModel.h"
#import "PLSyncLinkViewController.h"

#define PossibleStates @{ @"0" : State_PlantType, @"1" : State_SoilType, @"2" : State_Nickname}

@interface PLPlantSetupViewController() {
@private
    PLItemRequest *plantRequest;
    PLItemRequest *plantUpdateRequest;
    
    PLPlantModel *createdModel;
    UITableView *itemsTableView;
    
    NSArray *plantTypes;
    NSArray *soilTypes;
    NSString *state;
    
    NSMutableArray *drillDownPlants;
    NSMutableArray *drillDownSoils;
    
    NSString *nickname;
    NSString *plantName;
    NSString *plantTypeKey;
    NSString *soilName;
    NSString *soilTypeKey;
}

@end

@implementation PLPlantSetupViewController

/**
 * Sets the intial parameters for the view, and adds the table view
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    plantTypes = [sharedUser plantTypes];
    soilTypes = [sharedUser soilTypes];
    
    drillDownPlants = [NSMutableArray array];
    drillDownSoils = [NSMutableArray array];
    
    [self addTableView];
    
    [itemsTableView setAlpha:0.0f];
    [titleLabel setAlpha:0.0f];
    [inputTextField setAlpha:0.0f];
    [stepLabel setAlpha:0.0f];
    
    plantName = @"";
    soilName = @"";
    nickname = @"";
    
    state = State_PlantType;
    [self update];

    
    _initialState = State_PlantType;
    _updateMode = NO;
    _skipToSync = NO;
    _plantToUpdate = NULL;
}

/**
 * Updates the plant edit parameters from the user edit plant dict, taking the appriopriate action
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSMutableDictionary *dict = [sharedUser plantEditDict];
    NSLog(@"%@",dict);
    
    _skipToSync = [dict.allKeys containsObject:@"SkipToSync"];
    _updateMode = [dict.allKeys containsObject:@"UpdateMode"];
    _initialState = dict[@"InitialState"];
    _plantToUpdate = dict[@"Plant"];
    
    if(_skipToSync) {
        createdModel = _plantToUpdate;
        [self performSegueWithIdentifier:Segue_ToSyncLink sender:self];
    }
    else if(_updateMode) {
        [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
        [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextUpdatePushed:)];
        
        plantName = [[_plantToUpdate plantType] name];
        plantTypeKey = [_plantToUpdate plantTypeKey];
        soilName = [[_plantToUpdate soilType] name];
        soilTypeKey = [_plantToUpdate soilTypeKey];
        nickname = [_plantToUpdate name];
        
        state = _initialState;
        [self update];
    }
}

#pragma mark -
#pragma mark Display Methods

/**
 * Adds the item table view to the view
 */
-(void)addTableView {
    int height = ([UIScreen mainScreen].bounds.size.height < 568) ? 480-149 : 568-149;
    itemsTableView = [[UITableView alloc] initWithFrame:CGRectMake(30, 149, 320-2*30, height)];
    [itemsTableView setDataSource:self];
    [itemsTableView setDelegate:self];
    [itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [itemsTableView setBackgroundColor:Color_ViewBackground];
    [self.view addSubview:itemsTableView];
}

/**
 * Updates the parameters for a new plant type model
 */
-(void)updateToPlantNameModel:(PLPlantTypeModel*)plantTypeModel {
    plantName = [plantTypeModel name];
    plantTypeKey = [plantTypeModel key];
    [inputTextField setText:plantName];
}

/**
 * Updates the parameters for a new soil model
 */
-(void)updateToSoilTypeModel:(PLSoilModel*)soilModel {
    soilName = [soilModel name];
    soilTypeKey = [soilModel key];
    [inputTextField setText:soilName];
}

#pragma mark -
#pragma mark Actions 

/**
 * Goes to the previous step in the add plant process, or dismisses the view
 */
-(void)backPushed:(id)sender {
    [self.view endEditing:YES];
    
    if([state isEqualToString:State_Nickname]) {
        state = State_SoilType;
        [self update];
    }
    else if([state isEqualToString:State_SoilType]) {
        state = State_PlantType;
        [self update];
    }
    else [self dismissViewControllerAnimated:YES completion:^{}];
}

/**
 * Called when the next button is pushed, and attempts to move to the next step
 */
-(void)nextPushed:(id)sender {
    [self.view endEditing:YES];

    if([state isEqualToString:State_PlantType]) {
        if([plantName isEqualToString:@""]) [self displayErrorAlertWithMessage:Error_AddPlant_NoPlantType];
        else [self moveNextFromPlantTypeSelect];
    }
    else if([state isEqualToString:State_SoilType]) {
        if([soilName isEqualToString:@""]) [self displayErrorAlertWithMessage:Error_AddPlant_NoSoilType];
        else [self moveNextFromSoilTypeSelect];
    }
    else {
        if([nickname isEqualToString:@""]) [self displayErrorAlertWithMessage:Error_AddPlant_NoNickname];
        else [self addPlantRequest];
    }
}

/**
 * If in update mode, this will perform the update request on the plant, download the new plant, and dismiss the controller
 */
-(void)nextUpdatePushed:(id)sender {
    plantUpdateRequest = [[PLItemRequest alloc] init];
    
    NSDictionary *updateDict = @{PostKey_SoilTypeKey : [NSNumber numberWithInt:[soilTypeKey intValue]], PostKey_PlantTypeKey : [NSNumber numberWithInt:[plantTypeKey intValue]], PostKey_Name : nickname};
    
    [plantUpdateRequest editPlant:[_plantToUpdate pid] paramDict:updateDict withResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if([dict isKindOfClass:[NSArray class]] && [self errorInRequestResponse:((NSArray*)dict)[0]]) return;
        else {
            _plantToUpdate = [PLPlantModel initWithDictionary:dict];
            [sharedUser plantEditDict][@"Plant"] = _plantToUpdate;
            [[sharedUser plantEditDict] removeObjectForKey:@"UpdateMode"];
            [[sharedUser plantEditDict] removeObjectForKey:@"InitialState"];
            
            [sharedUser setPlantReloadTrigger:YES];
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
    }];
}

/**
 * Attemps to go to the next step from the plant type select step
 */
-(void)moveNextFromPlantTypeSelect {
    BOOL contains = false;
    for(PLPlantTypeModel *model in plantTypes) {
        if([[[model name] lowercaseString] isEqualToString:[plantName lowercaseString]]) contains = true;
    }
    
    if(!contains) [self displayErrorAlertWithMessage:Error_AddPlant_InvalidPlantType];
    else {
        state = State_SoilType;
        [self update];
    }
}

/**
 * Attemps to go to the next step from the soil type select step
 */
-(void)moveNextFromSoilTypeSelect {
    BOOL contains = false;
    for(PLSoilModel *model in soilTypes) {
        if([[[model name] lowercaseString] isEqualToString:[soilName lowercaseString]]) contains = true;
    }
    if(!contains) [self displayErrorAlertWithMessage:Error_AddPlant_InvalidSoilType];
    else {
        state = State_Nickname;
        [self update];
    }
}

#pragma mark -
#pragma mark Request Methods

/**
 * Perfomrs the app plant request
 */
-(void)addPlantRequest {
    plantRequest = [[PLItemRequest alloc] init];
    [plantRequest addPlant:nickname type:plantTypeKey inSoil:soilTypeKey withResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        createdModel = [[PLPlantModel alloc] initWithDictionary:dict];
        [self performSegueWithIdentifier:Segue_ToSyncLink sender:self];
    }];
}

#pragma mark -
#pragma mark Display Methods

/**
 * Updates the subviews to display the first add plant step
 */
-(void)showStep1Info {
    [stepLabel setText:@"1"];
    [titleLabel setText:@"What type of plant do you have?"];
    [inputTextField setPlaceholder:@"ex. Basil"];
    [inputTextField setText:plantName];
}

/**
 * Updates the subviews to display the second add plant step
 */
-(void)showStep2Info {
    [stepLabel setText:@"2"];
    [titleLabel setText:@"What type of soil do you have?"];
    [inputTextField setPlaceholder:@"ex. Loam"];
    [inputTextField setText:soilName];
}

/**
 * Updates the subviews to display the third add plant step
 */
-(void)showStep3Info {
    [stepLabel setText:@"3"];
    [titleLabel setText:@"Give your plant a nickname."];
    [inputTextField setPlaceholder:@"ex. Bedroom Basil"];
    [inputTextField setText:nickname];
}

#pragma mark -
#pragma mark Text Field Methods

/**
 * Called when the value changed in the text field, filtering the suggestion table view
 */
-(IBAction)valueChanged:(id)sender {
    UITextField *textField = (UITextField*)sender;
    if([state isEqualToString:State_PlantType]) [self updateTableViewWithItemArray:drillDownPlants source:plantTypes fromTextField:textField];
    else if([state isEqualToString:State_SoilType]) [self updateTableViewWithItemArray:drillDownSoils source:soilTypes fromTextField:textField];
    else nickname = textField.text;
    
    [itemsTableView reloadData];
}

/**
 * Attemps to go to the next view when the return key is pressed, takes into account the update mode flag
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    if(_updateMode) [self nextUpdatePushed:nil];
    else [self nextPushed:nil];
    
    return YES;
}

#pragma mark -
#pragma mark Update Methods

/**
 * Updates the items array for the text in the text field, given a source array and the current items array
 */
-(void)updateTableViewWithItemArray:(NSMutableArray*)itemsArray source:(NSArray*)sourceArray fromTextField:(UITextField*)textField {
    NSString *text = textField.text;
    if([text length] > [itemsArray count]) {
        NSArray *last = [itemsArray lastObject];
        if([itemsArray count] == 0) last = sourceArray;
        NSMutableArray *new = [self prefixFilter:text fromSoils:last];
        [itemsArray addObject:new];
    }
    else if([text length] == [itemsArray count]-1) {
        [itemsArray removeLastObject];
    }
}

/**
 * Updates the view based on the current state, fading the subviews out and updating the necessary view parameters
 */
-(void)update {
    [UIView animateWithDuration:0.3 animations:^{

        [itemsTableView setAlpha:0.0f];
        [titleLabel setAlpha:0.0f];
        [inputTextField setAlpha:0.0f];
        [stepLabel setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [itemsTableView reloadData];
        if([itemsTableView numberOfRowsInSection:0] > 0) [itemsTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        if([state isEqualToString:State_PlantType]) [self showStep1Info];
        else if([state isEqualToString:State_SoilType]) [self showStep2Info];
        else if([state isEqualToString:State_Nickname]) [self showStep3Info];
        
        [UIView animateWithDuration:0.3 animations:^{
            if([state isEqualToString:State_Nickname]) [itemsTableView setAlpha:0.0f];
            else [itemsTableView setAlpha:1.0f];
            
            [titleLabel setAlpha:1.0f];
            [inputTextField setAlpha:1.0f];
            [stepLabel setAlpha:1.0f];
        }];
    }];
}

#pragma mark -
#pragma mark Display Methods

/**
 * Dismisses the keyboard if the view is touches outside the text field
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Content Methods

/**
 * Returns the array of plant models whose names match the given prefix
 */
-(NSMutableArray*)prefixFilter:(NSString*)prefix fromPlants:(NSArray*)plants {
    NSMutableArray *retArr = [NSMutableArray array];
    for(PLPlantTypeModel *plant in plants) {
        if([[[plant name] lowercaseString] rangeOfString:[prefix lowercaseString]].location != NSNotFound) {
            [retArr addObject:plant];
        }
    }
    return retArr;
}

/**
 * Returns the array of soil models whose names match the given prefix
 */
-(NSMutableArray*)prefixFilter:(NSString*)prefix fromSoils:(NSArray*)soils {
    NSMutableArray *retArr = [NSMutableArray array];
    for(PLSoilModel *soil in soils) {
        if([[[soil name] lowercaseString] rangeOfString:[prefix lowercaseString]].location != NSNotFound) [retArr addObject:soil];
    }
    return retArr;
}

#pragma mark -
#pragma mark TableView Methods

/**
 * Returns the number of cells in the table view based on the state of the view
 */
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

/**
 * Returns the table view cell, and updates the labels based on the state of the view
 */
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

/**
 * Updates the view if a cell is selected, setting the proper parameters for keeping track of user selection
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([state isEqualToString:State_PlantType]) {
        NSArray *plants = plantTypes;
        if([drillDownPlants count] > 0) plants = [drillDownPlants lastObject];
        
        PLPlantTypeModel *plant = plants[indexPath.row];
        [self updateToPlantNameModel:plant];
    }
    else if([state isEqualToString:State_SoilType]) {
        NSArray *soils = soilTypes;
        if([drillDownSoils count] > 0) soils = [drillDownSoils lastObject];
        
        PLSoilModel *soil = soils[indexPath.row];
        [self updateToSoilTypeModel:soil];
    }
}

/**
 * Returns the height of the table view cells
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

#pragma mark -
#pragma mark Prepare For Segue

/**
 * If the segue to the sync lync view is happening, the created model is pushed to the sync lync view
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:Segue_ToSyncLink]) {
        PLSyncLinkViewController *destination = [segue destinationViewController];
        [destination setCreatedPlant:createdModel];
        
    }
}

@end
