//
//  PLGerdenViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLGardenViewController : PLAbstractViewController <UICollectionViewDataSource,UICollectionViewDelegate> {
    IBOutlet UICollectionView *gardenCollectionView;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)refreshPushed:(id)sender;

@end
