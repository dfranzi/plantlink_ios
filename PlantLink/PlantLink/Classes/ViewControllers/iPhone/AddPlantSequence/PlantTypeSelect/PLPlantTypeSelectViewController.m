//
//  PLPlantTypeSelectViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantTypeSelectViewController.h"

#import "PLPlantTypeRequest.h"
#import "PLPlantTypeModel.h"
#import "PLTextField.h"

@interface PLPlantTypeSelectViewController() {
@private
    PLPlantTypeRequest *plantTypeRequest;
    NSMutableArray *plants;
    NSMutableArray *filteredPlants;
}

@end

@implementation PLPlantTypeSelectViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToSoilTypeSelect];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    plants = [NSMutableArray array];
    filteredPlants = [NSMutableArray array];
    
    plantTypeRequest = [[PLPlantTypeRequest alloc] initPlantTypeRequest];
    [plantTypeRequest setDelegate:self];
    [plantTypeRequest startRequest];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(plantTypeRequest) [plantTypeRequest cancelRequest];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)popView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)helpPushed:(id)sender {
    #warning Help not yet implemeneted
}

-(IBAction)plantTypeTextEditted:(id)sender {
    filteredPlants = [NSMutableArray array];
    
    for(PLPlantTypeModel *model in plants) {
        NSString *modelName = [[model name] lowercaseString];
        NSString *textString = [[plantTypeTextField text] lowercaseString];
        
        if([textString isEqual:@""]) [filteredPlants addObject:model];
        else {
            NSRange range = [modelName rangeOfString:textString options:NSRegularExpressionSearch];
            if (range.location != NSNotFound) [filteredPlants addObject:model];
        }
    }
    [plantTypeTableView reloadData];
}

#pragma mark -
#pragma mark Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [filteredPlants count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_PlantType];
    
    PLPlantTypeModel *model = filteredPlants[indexPath.row];
    UILabel *typeLabel = (UILabel*)[cell.contentView viewWithTag:1];
    [typeLabel setText:[model name]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Text View Methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

#pragma mark -
#pragma mark Request Methods

-(void)requestDidFinish:(AbstractRequest *)request {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[request data] options:NSJSONReadingMutableLeaves error:nil];
    
    plants = [PLPlantTypeModel modelsFromArrayOfDictionaries:array];

    filteredPlants = [NSMutableArray array];
    for(PLPlantTypeModel *model in plants) [filteredPlants addObject:model];
    
    [plantTypeTableView reloadData];
}

@end
