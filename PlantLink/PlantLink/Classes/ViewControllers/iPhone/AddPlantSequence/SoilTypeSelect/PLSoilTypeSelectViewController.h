//
//  PLSoilTypeSelectViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLSoilTypeSelectViewController : PLAbstractViewController <UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UITableView *soilTypeTableView;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)helpPushed:(id)sender;

@end
