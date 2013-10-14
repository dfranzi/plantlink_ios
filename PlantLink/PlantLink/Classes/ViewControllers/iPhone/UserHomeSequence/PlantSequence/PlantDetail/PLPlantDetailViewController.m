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
#import "PLPlantHelpCell.h"

@interface PLPlantDetailViewController() {
@private
    NSArray *plantCells;
}

@end

@implementation PLPlantDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _editMode = NO;
    _infoMode = NO;
    
    plantCells = Cell_PlantsAll;
    [plantTableView setBackgroundColor:Color_ViewBackground];
    [plantTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [plantTableView reloadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_Plant_Edit object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_Plant_Info object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Notification Methods

-(void)receivedNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:Notification_Plant_Edit]) {
        NSNumber *object = (NSNumber*)[notification object];
        [self setEditMode:[object boolValue]];
    }
    else if([[notification name] isEqualToString:Notification_Plant_Info]) {
        NSNumber *object = (NSNumber*)[notification object];
        [self setInfoMode:[object boolValue]];
    }
}

#pragma mark -
#pragma mark Setters

-(void)setEditMode:(BOOL)editMode {
    BOOL prev = _editMode;
    _editMode = editMode;
    
    [plantTableView beginUpdates];
    if(prev && !_editMode) {
        plantCells = Cell_PlantsAll;
        [plantTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];\
    }
    else if(!prev && _editMode) {
        plantCells = @[Cell_PlantTitle, Cell_PlantDetail, Cell_PlantHistory, Cell_PlantLinkDetail, Cell_PlantHelp];
        [plantTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0],[NSIndexPath indexPathForRow:4 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    [plantTableView endUpdates];
}

-(void)setInfoMode:(BOOL)infoMode {
    _infoMode = infoMode;
    
    [plantTableView beginUpdates];
    [plantTableView endUpdates];
}

#pragma mark -
#pragma mark Table View Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [plantCells count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = plantCells[indexPath.row];
    PLAbstractPlantDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if([cellIdentifier isEqualToString:Cell_PlantTitle]) [(PLPlantNameCell*)cell setEnclosingController:self];
    
    [cell setInfoText:InfoText_All[indexPath.row]];
    [cell setModel:_model];
    
    if(_infoMode) [cell showInfo];
    else [cell hideInfo];
    
    if(_editMode) [cell showEdit];
    else [cell hideEdit];
    [cell updateBorder];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    infoDict[PlantInfo_EditMode] = [NSNumber numberWithBool:_editMode];
    infoDict[PlantInfo_InfoMode] = [NSNumber numberWithBool:_infoMode];
    infoDict[PlantInfo_InfoText] = InfoText_All[indexPath.row];
    
    NSString *cellIdentifier = plantCells[indexPath.row];
    if([cellIdentifier isEqualToString:Cell_PlantTitle]) return [PLPlantNameCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantDetail]) return [PLPlantDetailsCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantMoisture]) return [PLPlantSoilCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantHistory]) return [PLPlantHistoryCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantSchedule]) return [PLPlantScheduleCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantLinkDetail]) return [PLPlantLinkCell heightForContent:infoDict];
    else if([cellIdentifier isEqualToString:Cell_PlantHelp]) return [PLPlantHelpCell heightForContent:infoDict];
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
