//
//  PLMyGardenViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLMyGardenViewController.h"

#import "PLUserManager.h"
#import "PLPlantModel.h"
#import "PLMyGardenCell.h"

@interface PLMyGardenViewController() {
@private
    NSArray *myPlants;
}

@end

@implementation PLMyGardenViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    myPlants = @[];
    
    [loadingLabel setFont:[UIFont fontWithName:Font_Bariol_Light size:45.0]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotification:) name:Notification_User_UserRefreshed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNotification:) name:Notification_User_UserRefreshFailed object:nil];
    [sharedUser refreshData];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Notification Methods

-(void)refreshNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:Notification_User_UserRefreshed]) {
        myPlants = [sharedUser plants];
        [gardenCollectionView reloadData];
    }
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)logoutPushed:(id)sender {
    [sharedUser logout];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Collection View Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([myPlants count] == 0) [loadingLabel setAlpha:1.0];
    else [loadingLabel setAlpha:0.0f];
    return [myPlants count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = Cell_GardenCell;
    PLMyGardenCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    PLPlantModel *model = myPlants[indexPath.row];
    [cell setModel:model];
    
    return cell;
}



@end
