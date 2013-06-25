//
//  PLTourViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLTourViewController : PLAbstractViewController <UICollectionViewDataSource,UICollectionViewDelegate> {
    IBOutlet UICollectionView *tourCollectionView;
}

@end
