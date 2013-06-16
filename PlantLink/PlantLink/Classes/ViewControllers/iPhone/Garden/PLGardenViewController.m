//
//  PLGerdenViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLGardenViewController.h"

#import "PLUserManager.h"
#import "PLMyGardenCell.h"

@interface PLGardenViewController() {
@private
    BOOL initialLoad;
}
@end

@implementation PLGardenViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    initialLoad = YES;
    [sharedUser refreshData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recievedNotification:) name:Notification_User_UserRefreshed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recievedNotification:) name:Notification_User_UserRefreshFailed object:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if(!initialLoad) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recievedNotification:) name:Notification_User_UserRefreshed object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recievedNotification:) name:Notification_User_UserRefreshFailed object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    initialLoad = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Notification Methods

-(void)recievedNotification:(NSNotification*)notification {
    [gardenCollectionView reloadData];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)refreshPushed:(id)sender {
    [sharedUser refreshData];
}

#pragma mark -
#pragma mark Collection Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[sharedUser plants] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLMyGardenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_GardenCell forIndexPath:indexPath];
    
    PLPlantModel *model = [[sharedUser plants] objectAtIndex:indexPath.row];
    [cell setModel:model];
    
    return cell;
}

@end
