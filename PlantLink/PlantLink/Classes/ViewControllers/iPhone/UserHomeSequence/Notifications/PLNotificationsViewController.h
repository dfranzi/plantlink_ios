//
//  PLNotificationsViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLNotificationsViewController : PLAbstractViewController <UICollectionViewDataSource,UICollectionViewDelegate> {
    IBOutlet UICollectionView *notificationCollectionView;
}

@end
