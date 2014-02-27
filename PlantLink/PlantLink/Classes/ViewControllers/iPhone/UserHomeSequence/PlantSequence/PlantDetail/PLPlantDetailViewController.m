//
//  PLPlantDetailViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailViewController.h"

#import "PLUserManager.h"
#import "PLPlantModel.h"
#import "PLAbstractPlantDetailCell.h"
#import "PLPlantNameCell.h"
#import "PLPlantDetailsCell.h"
#import "PLPlantSoilCell.h"
#import "PLPlantHistoryCell.h"
#import "PLPlantScheduleCell.h"
#import "PLPlantLinkCell.h"
#import "PLItemRequest.h"

#import "PLPlantSetupViewController.h"

@interface PLPlantDetailViewController() {
@private
    NSArray *plantCells;
    
    NSArray *originalCells;
    NSArray *editCells;
    NSArray *editRemoveIndexes;
    
    PLItemRequest *deleteRequest;
    
    BOOL editMode;
    BOOL firstAlertFlag;
}

@end

@implementation PLPlantDetailViewController

/**
 * Sets initial parameters when the view loads, and updates the table view to the screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    originalCells = Cell_PlantsAll;
    editRemoveIndexes = @[[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:4 inSection:0]];
    
    if([Link_Statuses containsObject:self.model.status]) {
        editRemoveIndexes = @[[NSIndexPath indexPathForRow:2 inSection:0]];
        originalCells = Cell_Plants_NoWaterDate;
    }
    plantCells = originalCells;
    
    [plantTableView setBackgroundColor:Color_ViewBackground];
    [plantTableView reloadData];
    editMode = NO;
    firstAlertFlag = NO;
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [plantTableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
}

/**
 * Reloads the plant table view when the view appears, shows an alert to help users sync a link or to check their link
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_Plant_Edit object:nil];
    
    [self refreshData];
    
    if([[_model status] isEqualToString:@"No Link"] && !firstAlertFlag) {
        firstAlertFlag = YES;
        UIAlertView *syncAlert = [[UIAlertView alloc] initWithTitle:@"Sync your Link?" message:@"This plant is not synced with a Link. Would you like to sync it now?" delegate:self cancelButtonTitle:@"Later" otherButtonTitles:@"Sync Now", @"Delete", nil];
        [syncAlert show];
    }
    else if(firstAlertFlag) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
}

/**
 * Unregisters from notifications to avoid a potential memory leak
 */
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Alert Methods

/**
 * Handles buttons click on the alert, either dismissing the view or performing a segue
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == [alertView cancelButtonIndex]) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    else if(buttonIndex == 1) {
        [sharedUser plantEditDict][@"SkipToSync"] = @YES;
        [self performSegueWithIdentifier:Segue_ToAddPlantSequence sender:@""];
    }
    else if(buttonIndex == 2) {
        deleteRequest = [[PLItemRequest alloc] init];
        [deleteRequest removePlant:self.model.pid withResponse:^(NSData *data, NSError *error) {
            sharedUser.plantReloadTrigger = YES;
            [self dismissViewControllerAnimated:YES completion:^{}];
        }];
    }
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
        BOOL previousEdit = editMode;
        editMode = [editModeIndicator boolValue];
        
        for(PLAbstractPlantDetailCell *cell in plantTableView.visibleCells) [cell setEditMode:editMode];
        
        [plantTableView beginUpdates];
        
        if(editMode && !previousEdit) {
            plantCells = Cell_PlantsEdit;
            [plantTableView deleteRowsAtIndexPaths:editRemoveIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        else if(!editMode && previousEdit) {
            plantCells = originalCells;
            [plantTableView insertRowsAtIndexPaths:editRemoveIndexes withRowAnimation:UITableViewRowAnimationAutomatic];
        }
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
        [sharedUser plantEditDict][@"UpdateMode"] = @YES;
        [sharedUser plantEditDict][@"Plant"] = _model;
        [sharedUser plantEditDict][@"InitialState"] = (NSString*)sender;
    }
}

@end
