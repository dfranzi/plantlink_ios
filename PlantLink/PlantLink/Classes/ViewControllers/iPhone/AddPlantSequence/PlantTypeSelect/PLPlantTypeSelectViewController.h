//
//  PLPlantTypeSelectViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLTextField;
@interface PLPlantTypeSelectViewController : PLAbstractViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet PLTextField *plantTypeTextField;
    IBOutlet UITableView *plantTypeTableView;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)helpPushed:(id)sender;
-(IBAction)plantTypeTextEditted:(id)sender;

@end
