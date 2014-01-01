//
//  PLPlantNameCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantNameCell.h"

#import "PLPlantDetailViewController.h"
#import "PLPlantModel.h"

@implementation PLPlantNameCell

#pragma mark -
#pragma mark Setters 

/**
 * Overrides the edit mode setter to also move over the name label so that the edit button can be clearly seen
 */
-(void)setEditMode:(BOOL)editMode {
    [super setEditMode:editMode];
    
    [UIView animateWithDuration:0.3 animations:^{
        if(editMode && nameLabel.tag == 0) {
            [nameLabel setCenter:CGPointMake(nameLabel.center.x+15, nameLabel.center.y)];
            nameLabel.tag = 1;
        }
        else if(!editMode && nameLabel.tag == 1) {
            [nameLabel setCenter:CGPointMake(nameLabel.center.x-15, nameLabel.center.y)];
            nameLabel.tag = 0;
        }
    }];
}

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
    [[self enclosingController] dismissViewControllerAnimated:YES completion:^{}];
}

/**
 * Pulls up the edit mode controller set to update the nickname
 */
-(IBAction)plantNameEditPushed:(id)sender {
    [[self enclosingController] performSegueWithIdentifier:Segue_ToAddPlantSequence sender:State_Nickname];
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
