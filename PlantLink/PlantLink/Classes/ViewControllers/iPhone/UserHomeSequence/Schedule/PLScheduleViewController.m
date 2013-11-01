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
    PLItemRequest *plantRequest;
}

@end

@implementation PLScheduleViewController

-(void)viewDidLoad {
    ZALog(@"Schedule");
    [super viewDidLoad];
    
    UIImage *schedule = [UIImage imageNamed:Image_Tab_Schedule];
    UIImage *scheduleHighlighted = [UIImage imageNamed:Image_Tab_ScheduleHighlighted];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:scheduleHighlighted withFinishedUnselectedImage:schedule];
    
    [scheduleCollectionView setBackgroundColor:Color_ViewBackground];
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [scheduleCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];

    schedules = @[];
    [scheduleCollectionView reloadData];
    reloadSchedule = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(reloadSchedule) {
        reloadSchedule = NO;
        plantRequest = [[PLItemRequest alloc] init];
        [plantRequest getUserPlantsWithResponse:^(NSData *data, NSError *error) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            schedules = [PLPlantModel modelsFromArrayOfDictionaries:array];
            
            schedules = [schedules sortedArrayUsingComparator:^NSComparisonResult(PLPlantModel *obj1, PLPlantModel *obj2) {
                return [[[obj1 lastMeasurement] predictedWaterDate] compare:[[obj2 lastMeasurement] predictedWaterDate]];
            }];
            
            NSMutableArray *indexes = [NSMutableArray array];
            for(int i = 0; i < [schedules count]; i++) [indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            
            [scheduleCollectionView insertItemsAtIndexPaths:indexes];
        }];
    }
}

#pragma mark -
#pragma mark CollectionView Methods


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [schedules count]+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [schedules count]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Edit forIndexPath:indexPath];
        [cell.contentView setBackgroundColor:collectionView.backgroundColor];
        return cell;
    }
    
    PLScheduleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Schedule forIndexPath:indexPath];
    [cell setPlant:schedules[indexPath.row]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [schedules count]) return CGSizeMake(297.0, 85.0);
    return [PLScheduleCell sizeForContent:@{}];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == [schedules count]) [self performSegueWithIdentifier:@"toScheduleEditView" sender:self];
}

@end
