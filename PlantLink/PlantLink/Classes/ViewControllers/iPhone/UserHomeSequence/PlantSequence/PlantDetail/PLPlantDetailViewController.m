//
//  PLPlantDetailViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailViewController.h"

#import "PLPlantNameCell.h"
#import "PLPlantSoilCell.h"
#import "PLPlantHistoryCell.h"
#import "PLPlantScheduleCell.h"
#import "PLPlantLinkCell.h"
#import "PLPlantHelpCell.h"

@interface PLPlantDetailViewController() {
@private
}

@end

@implementation PLPlantDetailViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _editMode = NO;
    _infoMode = NO;
    [plantTableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
    _editMode = editMode;
    [plantTableView beginUpdates];
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
    return [Cell_PlantsAll count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = Cell_PlantsAll[indexPath.row];
    if([cellIdentifier isEqualToString:Cell_PlantTitle]) {
        PLPlantNameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setEnclosingController:self];
        [cell setInfoText:InfoText_All[indexPath.row]];
        return cell;
    }
    else if([cellIdentifier isEqualToString:Cell_PlantMoisture]) {
        PLPlantSoilCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setInfoText:InfoText_All[indexPath.row]];
        return cell;
    }
    else if([cellIdentifier isEqualToString:Cell_PlantHistory]) {
        PLPlantHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setInfoText:InfoText_All[indexPath.row]];
        return cell;
    }
    else if([cellIdentifier isEqualToString:Cell_PlantSchedule]) {
        PLPlantScheduleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setInfoText:InfoText_All[indexPath.row]];
        return cell;
    }
    else if([cellIdentifier isEqualToString:Cell_PlantLinkDetail]) {
        PLPlantLinkCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setInfoText:InfoText_All[indexPath.row]];
        return cell;
    }
    else if([cellIdentifier isEqualToString:Cell_PlantHelp]) {
        PLPlantHelpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        [cell setInfoText:InfoText_All[indexPath.row]];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    infoDict[PlantInfo_EditMode] = [NSNumber numberWithBool:_editMode];
    infoDict[PlantInfo_InfoMode] = [NSNumber numberWithBool:_infoMode];
    infoDict[PlantInfo_InfoText] = InfoText_All[indexPath.row];
    
    NSString *cellIdentifier = Cell_PlantsAll[indexPath.row];
    if([cellIdentifier isEqualToString:Cell_PlantTitle]) return [PLPlantNameCell heightForContent:infoDict];
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
