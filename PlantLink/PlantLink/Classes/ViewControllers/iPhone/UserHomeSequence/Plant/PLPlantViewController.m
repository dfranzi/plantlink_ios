//
//  PLPlantViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantViewController.h"

#import "PLUserManager.h"
#import "PLPlantModel.h"
#import "PLPlantCell.h"
#import "PLPlantRequest.h"

@interface PLPlantViewController() {
@private
    PLPlantRequest *plantRequest;
    NSMutableArray *plants;
    
    NSDate *lastReload;
}

@end

@implementation PLPlantViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    lastReload = NULL;
    [sharedUser setPlantReloadTrigger:YES];
}

-(void)viewWillAppear:(BOOL)animated {
    if([sharedUser plantReloadTrigger]) [self reloadPlants];
    else if(lastReload) {
        NSDate *interval = [lastReload dateByAddingTimeInterval:60*60];
        if([interval compare:[NSDate date]] == NSOrderedAscending) [self reloadPlants];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    if(plantRequest) [plantRequest cancelRequest];
}

#pragma mark -
#pragma mark Collection View Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [plants count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLPlantCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_PlantCell forIndexPath:indexPath];
    
    PLPlantModel *model = plants[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [PLPlantCell sizeForContent:@{}];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self.tabBarController performSegueWithIdentifier:Segue_ToAddPlantSequence sender:self];
}

#pragma mark -
#pragma mark Request Methods

-(void)reloadPlants {
    plants = [NSMutableArray array];
    [plantCollectionView reloadData];
    
    plantRequest = [[PLPlantRequest alloc] initGetAllUserPlantsRequest];
    [plantRequest setDelegate:self];
    [plantRequest startRequest];

}

-(void)requestDidFinish:(AbstractRequest *)request {
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[request data] options:NSJSONReadingMutableLeaves error:nil];
    plants = [PLPlantModel modelsFromArrayOfDictionaries:array];
    [plantCollectionView reloadData];
    lastReload = [NSDate date];
    [sharedUser setPlantReloadTrigger:NO];
}

@end
