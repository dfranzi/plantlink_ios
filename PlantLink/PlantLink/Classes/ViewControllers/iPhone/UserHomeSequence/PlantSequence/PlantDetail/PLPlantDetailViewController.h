//
//  PLPlantDetailViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLPlantModel;
@interface PLPlantDetailViewController : PLAbstractViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate> {
    IBOutlet UITableView *plantTableView;
}
@property(nonatomic, strong) PLPlantModel *model;

#pragma mark -
#pragma mark Display Methods

-(void)refreshData;

@end
