//
//  PLSoilTypeSelectViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSoilTypeSelectViewController.h"

#import "PLSoilModel.h"
#import "PLSoilTypeRequest.h"

@interface PLSoilTypeSelectViewController() {
@private
    NSMutableArray *soil;
    PLSoilTypeRequest *soilRequest;
}

@end

@implementation PLSoilTypeSelectViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToPlantNicknameSelect];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    soil = [NSMutableArray array];
    
    soilRequest = [[PLSoilTypeRequest alloc] initSoilTypeRequest];
    [soilRequest setDelegate:self];
    [soilRequest startRequest];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(soilRequest) [soilRequest cancelRequest];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)helpPushed:(id)sender {
    #warning Help not yet implemeneted
}

#pragma mark -
#pragma mark Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [soil count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell_SoilType];
    
    PLSoilModel *model = soil[indexPath.row];
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
#pragma mark Request Methods

-(void)requestDidFinish:(AbstractRequest *)request {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[request data] options:NSJSONReadingMutableLeaves error:nil];
    
    soil = [PLSoilModel modelsFromArrayOfDictionaries:array];
    [soilTypeTableView reloadData];
}

@end
