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

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *clock = [UIImage imageNamed:Image_Tab_Clock];
    UIImage *clockHighlighted = [UIImage imageNamed:Image_Tab_ClockHighlighted];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:clockHighlighted withFinishedUnselectedImage:clock];
    
    [notificationCollectionView setBackgroundColor:Color_ViewBackground];
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [notificationCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    
    notifications = @[];
    [notificationCollectionView reloadData];
    reloadNotifications = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if(reloadNotifications) {
        reloadNotifications = NO;
        
        notificationRequest = [[PLItemRequest alloc] init];
        [notificationRequest getNotificationsWithResponse:^(NSData *data, NSError *error) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

            notifications = [PLNotificationModel modelsFromArrayOfDictionaries:array];
            notifications = [notifications sortedArrayUsingComparator:^NSComparisonResult(PLNotificationModel *obj1, PLNotificationModel *obj2) {
                return [[obj2 notificationTime] compare:[obj1 notificationTime]];
            }];
            
            NSMutableArray *indexes = [NSMutableArray array];
            for(int i = 0; i < [notifications count]; i++) [indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
            
            [notificationCollectionView insertItemsAtIndexPaths:indexes];
        }];
    }
}

#pragma mark -
#pragma mark CollectionView Methods


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [notifications count]+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [notifications count]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Edit forIndexPath:indexPath];
        [cell.contentView setBackgroundColor:collectionView.backgroundColor];
        return cell;
    }
    
    PLNotificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Notification forIndexPath:indexPath];
    [cell setNotification:notifications[indexPath.row]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [notifications count]) return CGSizeMake(297.0, 85.0);
    PLNotificationModel *notification = notifications[indexPath.row];
    return [PLNotificationCell sizeForContent:@{ NotificationInfo_Text : [notification kind] }];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == [notifications count]) [self performSegueWithIdentifier:Segue_ToNotificationSettings sender:self];
}



@end
