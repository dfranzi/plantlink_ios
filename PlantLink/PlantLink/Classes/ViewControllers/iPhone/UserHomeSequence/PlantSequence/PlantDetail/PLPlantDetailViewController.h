//
//  PLPlantDetailViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/23/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLPlantDetailViewController : PLAbstractViewController <UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITableView *plantTableView;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)dismissPushed:(id)sender;

@end
