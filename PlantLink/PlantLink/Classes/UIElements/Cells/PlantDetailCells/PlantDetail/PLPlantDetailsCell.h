//
//  PLPlantDetailsCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@interface PLPlantDetailsCell : PLAbstractPlantDetailCell <UIAlertViewDelegate> {
    IBOutlet UILabel *plantTypeLabel;
    IBOutlet UILabel *soilTypeLabel;
    IBOutlet UILabel *locationLabel;
}

#pragma mark -
#pragma mark Action Methods

-(IBAction)plantTypeEditPushed:(id)sender;
-(IBAction)soilTypeEditPushed:(id)sender;
-(IBAction)locationEditPushed:(id)sender;

@end
