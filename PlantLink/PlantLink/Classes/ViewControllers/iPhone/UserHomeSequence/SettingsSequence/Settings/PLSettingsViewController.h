//
//  PLSettingsViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLSettingsViewController : PLAbstractViewController <UICollectionViewDelegate,UICollectionViewDataSource> {
    IBOutlet UICollectionView *settingsCollectionView;
}

@end
