//
//  PLPlantNameCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantNameCell.h"

#import "PLPlantModel.h"

@implementation PLPlantNameCell

#pragma mark -
#pragma mark Setters 

/**
 * Updates the name cell based on a new model
 */
-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    if([self model]) {
        [nameLabel setText:[[self model] name]];

        NSString *dateStr = [GeneralMethods stringFromDate:[[self model] created] withFormat:@"MMM, yyyy"];
        [activeOnLabel setText:[NSString stringWithFormat:@"Active since %@",dateStr]];
    }
}

#pragma mark -
#pragma mark IBAction Methods

/**
 * Dismisses the view controller by using the enclosing view controller pointer
 */
-(IBAction)backPushed:(id)sender {
    [_enclosingController dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the height for the cell
 */
+(CGFloat)heightForContent:(NSDictionary*)content {
    return 120+[super heightForContent:content];
}

@end
