//
//  PLInformationViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLInformationViewController : PLAbstractViewController <UICollectionViewDataSource,UIScrollViewDelegate> {
    IBOutlet UICollectionView *infoCollectionView;
    IBOutlet UIPageControl *infoPageControl;
}

@end
