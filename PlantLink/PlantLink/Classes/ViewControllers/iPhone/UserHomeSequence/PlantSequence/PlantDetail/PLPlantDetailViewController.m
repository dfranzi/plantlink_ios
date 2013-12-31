//
//  PLPlantDetailViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailViewController.h"

#import "PLPlantNameCell.h"
#import "PLPlantDetailsCell.h"
#import "PLPlantSoilCell.h"
#import "PLPlantHistoryCell.h"
#import "PLPlantScheduleCell.h"
#import "PLPlantLinkCell.h"

@interface PLPlantDetailViewController() {
@private
    NSArray *plantCells;
}

@end

@implementation PLPlantDetailViewController

/**
 * Sets initial parameters when the view loads, and updates the table view to the screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    plantCells = Cell_PlantsAll;
    [plantTableView setBackgroundColor:Color_ViewBackground];
    [plantTableView reloadData];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [plantTableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
}

/**
 * Reloads the plant table view when the view appears
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [plantTableView reloadData];
}

#pragma mark -
#pragma mark Table View Methods

/**
 * Returns the number of plant cells to be displayed
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [plantCells count];
}

/**
 * Returns the uitableview cell for the cell at the given index path, setting the plant model
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = plantCells[indexPath.row];
    PLAbstractPlantDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if([cellIdentifier isEqualToString:Cell_PlantTitle]) [(PLPlantNameCell*)cell setEnclosingController:self];
    
    [cell setModel:_model];
    [cell updateBorder];
    
    return cell;
}

/**
 * Returns hieght of the cell at a given index path
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    
    NSString *cellIdentifier = plantCells[indexPath.row];
    if([cellIdentifier isEqualToString:Cell_PlantTitle]) return [PLPlantNameCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantDetail]) return [PLPlantDetailsCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantMoisture]) return [PLPlantSoilCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantHistory]) return [PLPlantHistoryCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantSchedule]) return [PLPlantScheduleCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantLinkDetail]) return [PLPlantLinkCell heightForContent:infoDict];
    return 0;
}

@end
