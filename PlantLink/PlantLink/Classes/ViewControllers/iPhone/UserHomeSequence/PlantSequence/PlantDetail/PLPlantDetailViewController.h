//
//  PLPlantDetailViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLPlantModel;
@interface PLPlantDetailViewController : PLAbstractViewController <UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *plantTableView;
}
@property(nonatomic, strong) PLPlantModel *model;
@property(nonatomic, assign) BOOL editMode;
@property(nonatomic, assign) BOOL infoMode;

@end
