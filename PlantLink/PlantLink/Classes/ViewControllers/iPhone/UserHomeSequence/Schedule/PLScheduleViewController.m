//
//  PLCalendarViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleViewController.h"
#import "PLScheduleCell.h"
#import "PLItemRequest.h"
#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"

@interface PLScheduleViewController() {
@private
    NSArray *schedules;
    BOOL reloadSchedule;
    NSDate *lastRefresh;
    PLItemRequest *plantRequest;
    PLScheduleView *scheduleView;
}

@end

@implementation PLScheduleViewController

/**
 * Method called when the view loads, sets the proper tab bar icons, initializes some variables,
 * and adjusts the collection view size to the proper screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [scheduleCollectionView setBackgroundColor:Color_PlantLinkBackground];
    //[self setTabBarIconActive:Image_Tab_ScheduleHighlighted passive:Image_Tab_Schedule];
    
    scheduleView = [[PLScheduleView alloc] initWithFrame:CGRectMake(0, 0, 320, 140)];
    [scheduleView setDelegate:self];
    [self.view addSubview:scheduleView];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) {
        [scheduleView setCenter:CGPointMake(scheduleView.center.x, scheduleView.center.y-20)];
        [scheduleCollectionView setFrame:CGRectMake(0, 120, 320, self.view.frame.size.height-168+48)];
    }
    else [scheduleCollectionView setFrame:CGRectMake(0, 140, 320, self.view.frame.size.height-188)];

    schedules = @[];
    [scheduleCollectionView reloadData];
    reloadSchedule = YES;
}

/**
 * Reloads the view when it appears if the boolean flag is raised, or if the view was reloaded more than 60*60 seconds ago
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(reloadSchedule  || [[NSDate date] timeIntervalSinceDate:lastRefresh] > 60*60) {
        reloadSchedule = NO;
        [self refreshData];
    }
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
        lastRefresh = [NSDate date];
        schedules = [self sortedModelsFromScheduleData:data];
        [self addModelsToCollectionView:schedules];
        
        [scheduleView setPlants:schedules];
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
    PLScheduleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Notification forIndexPath:indexPath];
    PLPlantModel *plant = schedules[indexPath.row];
    [cell setNotificationTitle:[plant name] andTime:[[plant lastMeasurement] predictedWaterDate] sortOrder:NSOrderedDescending];
    return cell;
}

/**
 * Returns the size of the cell at a given index path
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [PLScheduleCell sizeForContent:@{}];
}

/**
 * Method is called when the cell at the given index path is selected
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark ScheduleView Delegate Methods

-(void)daySelected:(int)day {
    int index = 0;
    int selected = 0;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    for(PLPlantModel *plant in schedules) {
        NSDate *plantDate = [[plant lastMeasurement] predictedWaterDate];
        if(plantDate) {
            NSDateComponents *plantComponent = [calendar components:NSDayCalendarUnit fromDate:plantDate];
            if(day == [plantComponent day]) {
                selected = index;
                break;
            }

        }
        index++;
    }
    
    NSIndexPath *path = [NSIndexPath indexPathForRow:selected inSection:0];
    [scheduleCollectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

@end
