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
#import "PLItemRequest.h"
#import <QuartzCore/QuartzCore.h>
#import "PLPlantDetailViewController.h"

@interface PLPlantViewController() {
@private
    PLItemRequest *plantRequest;
    PLPlantModel *selectedPlant;
    NSMutableArray *plants;
    
    NSDate *lastReload;
}

@end

@implementation PLPlantViewController

/**
 * Sets the initial parameters of the view and ajusts the collection view to the screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    lastReload = NULL;
    
    [plantCollectionView setBackgroundColor:Color_PlantLinkBackground];
    [sharedUser setPlantReloadTrigger:YES];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [plantCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    
    //[self setTabBarIconActive:Image_Tab_LeafHighlighted passive:Image_Tab_Leaf];
}

/**
 * Reloads the plants if the trigger flag is set, otherwise checks to see if a reload was done more than an hour ago
 */
-(void)viewWillAppear:(BOOL)animated {
    if([sharedUser plantReloadTrigger]) [self reloadPlants];
    else if(lastReload) {
        NSDate *interval = [lastReload dateByAddingTimeInterval:60*60];
        if([interval compare:[NSDate date]] == NSOrderedAscending) [self reloadPlants];
    }
}

/**
 * Cancels the plant request if it exists
 */
-(void)viewWillDisappear:(BOOL)animated {
    if(plantRequest) [plantRequest cancel];
}

#pragma mark -
#pragma mark Collection View Methods

/**
 * Returns the number of plants in the collection view (+1 for the add plant button at the end)
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [plants count]+1;
}

/**
 * Returns the collection view cell for either the add plant button or a plant cell
 */
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

/**
 * Returns the size for the plant cell or the add plant cell given an index path
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == [plants count]) return CGSizeMake(295.0, 90.0);
    return [PLPlantCell sizeForContent:@{}];
}

/**
 * Called when a cell is selected, and performs the appriopriate transition
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == [plants count]) [self.tabBarController performSegueWithIdentifier:Segue_ToAddPlantSequence sender:self.tabBarController];
    else {
        selectedPlant = plants[indexPath.row];
        [self performSegueWithIdentifier:Segue_ToPlantDetail sender:self];
    }
}

#pragma mark -
#pragma mark Segue Methods

/**
 * Sets the selected plant on the next view if the transition is to the plant detail view
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:Segue_ToPlantDetail]) {
        PLPlantDetailViewController *destination = [segue destinationViewController];
        [destination setModel:selectedPlant];
    }
    
}

#pragma mark -
#pragma mark Request Methods

/**
 * Reloads the users plants and clears the collection view then displays the most recent plant information
 */
-(void)reloadPlants {
    plants = [NSMutableArray array];
    [plantCollectionView reloadData];
    
    plantRequest = [[PLItemRequest alloc] init];
    [plantRequest getUserPlantsWithResponse:^(NSData *data, NSError *error) {

        if(error) {
            [self requestError:error];
            return;
        }
        
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        plants = [PLPlantModel modelsFromArrayOfDictionaries:array];
        
        NSMutableArray *indexes = [NSMutableArray array];
        for(int i = 0; i < [plants count]; i++) [indexes addObject:[NSIndexPath indexPathForRow:i inSection:0]];
        
        [plantCollectionView insertItemsAtIndexPaths:indexes];
        
        lastReload = [NSDate date];
        [sharedUser setPlantReloadTrigger:NO];
    }];
}

@end
