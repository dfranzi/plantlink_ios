//
//  PLTourViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLTourViewController.h"

#import "PLTourCell.h"

@interface PLTourViewController() {
@private
    NSArray *contentArray;
}

@end

@implementation PLTourViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"TourLayout" ofType:@"strings"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    contentArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [tourCollectionView reloadData];
}

#pragma mark -
#pragma mark Collection View Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [contentArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = Cell_TourCell;
    
    PLTourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setPage:indexPath.row ofTotal:[contentArray count]];
    [cell setContentArray:contentArray[indexPath.row]];
    
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

@end
