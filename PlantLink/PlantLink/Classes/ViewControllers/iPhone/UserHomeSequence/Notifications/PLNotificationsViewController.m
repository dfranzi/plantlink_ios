//
//  PLNotificationsViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationsViewController.h"

#import "PLNotificationCell.h"

@interface PLNotificationsViewController() {
@private
    NSMutableArray *notifications;
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
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    notifications = [NSMutableArray arrayWithArray:@[@"Added first plant",@"Watered first plant",@"Bought a base station"]];
}

#pragma mark -
#pragma mark CollectionView Methods


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [notifications count]+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [notifications count]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Edit forIndexPath:indexPath];
        return cell;
    }
    
    PLNotificationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Notification forIndexPath:indexPath];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [notifications count]) return CGSizeMake(297.0, 85.0);
    return [PLNotificationCell sizeForContent:@{ NotificationInfo_Text : notifications[indexPath.row] }];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == [notifications count]) [self performSegueWithIdentifier:Segue_ToNotificationSettings sender:self];
}



@end
