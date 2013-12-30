//
//  PLCalendarViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleViewController.h"
#import "PLNotificationCell.h"
#import "PLItemRequest.h"
#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"

@interface PLScheduleViewController() {
@private
    NSArray *schedules;
    BOOL reloadSchedule;
    PLItemRequest *plantRequest;
}

@end

@implementation PLScheduleViewController

/**
 * Method called when the view loads, sets the proper tab bar icons, initializes some variables,
 * and adjusts the collection view size to the proper screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarIconActive:Image_Tab_ScheduleHighlighted passive:Image_Tab_Schedule];
    
    [scheduleCollectionView setBackgroundColor:Color_ViewBackground];
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [scheduleCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];

    schedules = @[];
    [scheduleCollectionView reloadData];
    reloadSchedule = YES;
}

/**
 * Reloads the view when it appears if the boolean flag is raised
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(reloadSchedule) {
        reloadSchedule = NO;
        [self refreshData];
    }
}

/**
 * Resets the boolean flag to reload the data for that view
 */
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    reloadSchedule = YES;
}

#pragma mark -
#pragma mark Data Methods

/**
 * Refreshse the dat aby downloading the newset set of items, and reloading the collection view
 */
-(void)refreshData {
    schedules = @[];
    [scheduleCollectionView reloadData];
    
    reloadSchedule = NO;
    plantRequest = [[PLItemRequest alloc] init];
    [plantRequest getUserPlantsWithResponse:^(NSData *data, NSError *error) {
        schedules = [self sortedModelsFromScheduleData:data];
        [self addModelsToCollectionView:schedules];
    }];
}

/**
 * Sorts the given plant models based on time
 */
-(NSArray*)sortedModelsFromScheduleData:(NSData*)data {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *items = [PLPlantModel modelsFromArrayOfDictionaries:array];
    
    return [items sortedArrayUsingComparator:^NSComparisonResult(PLPlantModel *obj1, PLPlantModel *obj2) {
        return [[[obj1 lastMeasurement] predictedWaterDate] compare:[[obj2 lastMeasurement] predictedWaterDate]];
    }];
}

/**
 * Adds the models to the collection view preserving order
 */
-(void)addModelsToCollectionView:(NSArray*)models {
    NSMutableArray *indexes = [NSMutableArray array];
    for(int i = 0; i < [models count]; i++) [indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    [scheduleCollectionView insertItemsAtIndexPaths:indexes];
}

#pragma mark -
#pragma mark CollectionView Methods

/**
 * Returns the number of items currently in the collection view
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [schedules count];
}

/**
 * Returns the collection view cell at a given index path
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLNotificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Notification forIndexPath:indexPath];
    PLPlantModel *plant = schedules[indexPath.row];
    [cell setNotificationTitle:[plant name] andTime:[[plant lastMeasurement] predictedWaterDate] sortOrder:NSOrderedDescending];
    return cell;
}

/**
 * Returns the size of the cell at a given index path
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [PLNotificationCell sizeForContent:@{}];
}

/**
 * Method is called when the cell at the given index path is selected
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
