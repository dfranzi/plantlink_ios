//
//  PLPlantDetailViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailViewController.h"

#import "PLUserManager.h"
#import "PLAbstractPlantDetailCell.h"
#import "PLPlantNameCell.h"
#import "PLPlantDetailsCell.h"
#import "PLPlantSoilCell.h"
#import "PLPlantHistoryCell.h"
#import "PLPlantScheduleCell.h"
#import "PLPlantLinkCell.h"

#import "PLPlantSetupViewController.h"

@interface PLPlantDetailViewController() {
@private
    NSArray *plantCells;
    BOOL editMode;
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
    editMode = NO;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [plantTableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
}

/**
 * Reloads the plant table view when the view appears
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_Plant_Edit object:nil];
    
    [self refreshData];
}

/**
 * Unregisters from notifications to avoid a potential memory leak
 */
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Display Methods

/**
 * Refreshes the views data, updating with the plant edit dict if necessary
 */
-(void)refreshData {
    if([sharedUser plantReloadTrigger]) {
        _model = [sharedUser plantEditDict][@"Plant"];
    }
    [plantTableView reloadData];
}

#pragma mark -
#pragma mark Notification Methods

/**
 * Handles the notification recieving, updating the edit mode for the edit mode notification 
 */
-(void)receivedNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:Notification_Plant_Edit]) {
        NSNumber *editModeIndicator = (NSNumber*)[notification object];
        editMode = [editModeIndicator boolValue];
        
        for(PLAbstractPlantDetailCell *cell in plantTableView.visibleCells) [cell setEditMode:editMode];
        
        [plantTableView beginUpdates];
        [plantTableView endUpdates];
    }
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
    
    [cell setEnclosingController:self];
    
    [cell setModel:_model];
    [cell setEditMode:editMode];
    [cell updateBorder];
    
    return cell;
}

/**
 * Returns hieght of the cell at a given index path
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    if(editMode) infoDict[@"EditMode"] = @YES;
        
    NSString *cellIdentifier = plantCells[indexPath.row];
    if([cellIdentifier isEqualToString:Cell_PlantTitle]) return [PLPlantNameCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantDetail]) return [PLPlantDetailsCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantMoisture]) return [PLPlantSoilCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantHistory]) return [PLPlantHistoryCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantSchedule]) return [PLPlantScheduleCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantLinkDetail]) return [PLPlantLinkCell heightForContent:infoDict];
    return 0;
}

#pragma mark -
#pragma mark Segue Methods

/**
 * Prepares for the add plant segue, updating the user plant edit dict
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:Segue_ToAddPlantSequence]) {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        dictionary[@"UpdateMode"] = @YES;
        dictionary[@"Plant"] = _model;
        dictionary[@"InitialState"] = (NSString*)sender;
        [sharedUser setPlantEditDict:dictionary];
    }
}

@end
