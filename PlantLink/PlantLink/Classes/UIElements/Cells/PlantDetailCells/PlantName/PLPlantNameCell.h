//
//  PLPlantNameCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@interface PLPlantNameCell : PLAbstractPlantDetailCell
@property(nonatomic, weak) UIViewController *enclosingController;

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender;
-(IBAction)editPushed:(id)sender;
-(IBAction)infoPushed:(id)sender;

@end
