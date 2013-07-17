//
//  PLPlantViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLPlantViewController : PLAbstractViewController <UICollectionViewDataSource,UICollectionViewDelegate> {
    IBOutlet UICollectionView *plantCollectionView;
}

@end
