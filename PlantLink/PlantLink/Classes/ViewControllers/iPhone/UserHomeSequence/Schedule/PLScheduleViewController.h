//
//  PLCalendarViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"
#import "PLScheduleView.h"

@interface PLScheduleViewController : PLAbstractViewController <UICollectionViewDataSource,UICollectionViewDelegate,PLScheduleViewDelegate> {
    IBOutlet UICollectionView *scheduleCollectionView;
}


@end
