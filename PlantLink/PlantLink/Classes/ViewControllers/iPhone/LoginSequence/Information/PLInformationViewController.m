//
//  PLInformationViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLInformationViewController.h"

@interface PLInformationViewController() {
@private
}

@end

@implementation PLInformationViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToAddFirstPlant];
    [infoCollectionView reloadData];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark Collection View Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5.0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_InformationCell forIndexPath:indexPath];
    
    UILabel *tutorialLabel = (UILabel*)[cell.contentView viewWithTag:1];
    [tutorialLabel setText:[NSString stringWithFormat:@"Tutorial #%i",indexPath.row+1]];
    
    CGFloat increment = 0.2*indexPath.row+0.2;
    UIColor *backgroundColor = [UIColor colorWithRed:increment green:increment-0.1*indexPath.row blue:increment-0.05*indexPath.row alpha:1.0];
    [cell setBackgroundColor:backgroundColor];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(306, 400);
}

#pragma mark -
#pragma mark ScrollView Delegate Methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updatePageControl];
}

-(void)updatePageControl {
    infoPageControl.currentPage = infoCollectionView.contentOffset.x / 320.0;
}

@end
