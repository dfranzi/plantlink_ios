//
//  PLNotificationsViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationsViewController.h"

#import "PLNotificationCell.h"
#import "PLItemRequest.h"
#import "PLNotificationModel.h"

@interface PLNotificationsViewController() {
@private
    NSArray *notifications;
    PLItemRequest *notificationRequest;
    
    BOOL reloadNotifications;
}

@end

@implementation PLNotificationsViewController

/**
 * Method called when the view loads, sets the proper tab bar icons, initializes some variables,
 * and adjusts the collection view size to the proper screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarIconActive:Image_Tab_ClockHighlighted passive:Image_Tab_Clock];
    
    [notificationCollectionView setBackgroundColor:Color_ViewBackground];
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [notificationCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    
    notifications = @[];
    [notificationCollectionView reloadData];
    reloadNotifications = YES;
}

/**
 * Reloads the view when it appears, if the boolean flag is set
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if(reloadNotifications) {
        reloadNotifications = NO;
        [self refreshData];
    }
}

/**
 * Resets the boolean flag to reload the data for that view
 */
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    reloadNotifications = YES;
}

#pragma mark -
#pragma mark Data Methods

/**
 * Refreshse the dat aby downloading the newset set of items, and reloading the collection view
 */
-(void)refreshData {
    notifications = @[];
    [notificationCollectionView reloadData];
    
    notificationRequest = [[PLItemRequest alloc] init];
    [notificationRequest getNotificationsWithResponse:^(NSData *data, NSError *error) {
        notifications = [self sortedModelsFromNotificationData:data];
        [self addModelsToCollectionView:notifications];
    }];
}

/**
 * Sorts the given notification models based on time
 */
-(NSArray*)sortedModelsFromNotificationData:(NSData*)data {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSMutableArray *items = [PLNotificationModel modelsFromArrayOfDictionaries:array];
    
    return [items sortedArrayUsingComparator:^NSComparisonResult(PLNotificationModel *obj1, PLNotificationModel *obj2) {
        return [[obj2 notificationTime] compare:[obj1 notificationTime]];
    }];
}

/**
 * Adds the models to the collection view preserving order
 */
-(void)addModelsToCollectionView:(NSArray*)models {
    NSMutableArray *indexes = [NSMutableArray array];
    for(int i = 0; i < [models count]; i++) [indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    [notificationCollectionView insertItemsAtIndexPaths:indexes];
}

#pragma mark -
#pragma mark CollectionView Methods

/**
 * Returns the number of items currently in the collection view
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [notifications count];
}

/**
 * Returns the collection view cell at a given index path
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLNotificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Notification forIndexPath:indexPath];
    PLNotificationModel *notification = notifications[indexPath.row];
    [cell setNotificationTitle:[PLNotificationCell displayTextForNotification:notification] andTime:[notification notificationTime] sortOrder:NSOrderedAscending];
    return cell;
}

/**
 * Returns the size of the cell at a given index path
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLNotificationModel *notification = notifications[indexPath.row];
    return [PLNotificationCell sizeForContent:@{ NotificationInfo_Text : [PLNotificationCell displayTextForNotification:notification] }];
}

/**
 * Method is called when the cell at the given index path is selected
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}



@end
