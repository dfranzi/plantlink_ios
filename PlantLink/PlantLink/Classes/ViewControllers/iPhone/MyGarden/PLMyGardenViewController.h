//
//  PLMyGardenViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLMyGardenViewController : PLAbstractViewController <UICollectionViewDelegate,UICollectionViewDataSource> {
    IBOutlet UICollectionView *gardenCollectionView;
    IBOutlet UILabel *loadingLabel;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)logoutPushed:(id)sender;

@end
