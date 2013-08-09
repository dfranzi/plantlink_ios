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
#import <QuartzCore/QuartzCore.h>
#import "PLPlantDetailViewController.h"

@interface PLPlantViewController() {
@private
    PLPlantRequest *plantRequest;
    PLPlantModel *selectedPlant;
    NSMutableArray *plants;
    
    NSDate *lastReload;
}

@end

@implementation PLPlantViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    lastReload = NULL;
    
    [plantCollectionView setBackgroundColor:Color_ViewBackground];
    [sharedUser setPlantReloadTrigger:YES];
    
    UIImage *leaf = [UIImage imageNamed:Image_Tab_Leaf];
    UIImage *leafHighlighted = [UIImage imageNamed:Image_Tab_LeafHighlighted];
        
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:leafHighlighted withFinishedUnselectedImage:leaf];
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
    return [plants count]+1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [plants count]) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_AddPlantCell forIndexPath:indexPath];
        [cell.layer setBorderWidth:0];
        [cell setBackgroundColor:[UIColor clearColor]];
        
        return cell;
    }
    
    
    PLPlantCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_PlantCell forIndexPath:indexPath];
    
    PLPlantModel *model = plants[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [plants count]) return CGSizeMake(295.0, 60.0);
    return [PLPlantCell sizeForContent:@{}];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == [plants count])
        [self.tabBarController performSegueWithIdentifier:Segue_ToAddPlantSequence sender:self.tabBarController];
    else {
        selectedPlant = plants[indexPath.row];
        [self performSegueWithIdentifier:Segue_ToPlantDetail sender:self];
    }
}

#pragma mark -
#pragma mark Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:Segue_ToPlantDetail]) {
        PLPlantDetailViewController *destination = [segue destinationViewController];
        [destination setModel:selectedPlant];
    }
    
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
