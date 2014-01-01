//
//  PLPlantDetailsCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailsCell.h"

#import "PLPlantDetailViewController.h"
#import "PLUserManager.h"

#import "PLItemRequest.h"
#import "PLPlantModel.h"
#import "PLPlantTypeModel.h"
#import "PLSoilModel.h"

@interface PLPlantDetailsCell() {
@private
    PLItemRequest *locationRequest;
}

@end

@implementation PLPlantDetailsCell

#pragma mark -
#pragma mark Action Methods

/**
 * Pulls up the edit mode controller set to update the plant type
 */
-(IBAction)plantTypeEditPushed:(id)sender {
    [[self enclosingController] performSegueWithIdentifier:Segue_ToAddPlantSequence sender:State_PlantType];
}

/**
 * Pulls up the edit mode controller set to update the soil type
 */
-(IBAction)soilTypeEditPushed:(id)sender {
    [[self enclosingController] performSegueWithIdentifier:Segue_ToAddPlantSequence sender:State_SoilType];
}

/**
 * Shows an alert with the option to select the inside or the outside
 */
-(IBAction)locationEditPushed:(id)sender {
    UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"Update Location" message:@"Select what location this plant is in." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Inside",@"Outside", nil];
    [locationAlert show];
}

#pragma mark -
#pragma mark Alert Methods

/**
 * Called when the alert view buttons are clicked, and updates the plant if necessary
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex == 1) {
        [self updatePlantWithNewLocation:@"Inside"];
    }
    else if(buttonIndex == 2) {
        [self updatePlantWithNewLocation:@"Outside"];
    }
}

#pragma mark -
#pragma mark Setters

/**
 * Overrides the edit mode to move over the information labels so that the edit buttons can be clearly seen
 */
-(void)setEditMode:(BOOL)editMode {
    [super setEditMode:editMode];
    
    [UIView animateWithDuration:0.3 animations:^{
        for(UIView *view in self.contentView.subviews) {
            if([view isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel*)view;
                if(editMode && label.tag == 0) {
                    [label setCenter:CGPointMake(label.center.x+15, label.center.y)];
                    label.tag = 1;
                }
                else if(!editMode && label.tag == 1) {
                    [label setCenter:CGPointMake(label.center.x-15, label.center.y)];
                    label.tag = 0;
                }
            }
        }
    }];
}


/**
 * Updates the text fields with the set model
 */
-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    [plantTypeLabel setBackgroundColor:Color_ViewBackground];
    [soilTypeLabel setBackgroundColor:Color_ViewBackground];
    [locationLabel setBackgroundColor:Color_ViewBackground];
    
    [super setModel:model];
    if([self model]) {
        PLPlantTypeModel *plantType = [[self model] plantType];
        PLSoilModel *soilType = [[self model] soilType];
        
        [plantTypeLabel setText:[plantType name]];
        [soilTypeLabel setText:[soilType name]];
        [locationLabel setText:[[self model] environment]];
    }
}

#pragma mark -
#pragma mark Request Methods

/**
 * Performs the update request for the plant with its new location, refreshing the views data when done
 */
-(void)updatePlantWithNewLocation:(NSString*)location {
    locationRequest = [[PLItemRequest alloc] init];
    [locationRequest editPlant:[[self model] pid] paramDict:@{PostKey_Environment : location} withResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        PLPlantModel *model = [PLPlantModel initWithDictionary:dict];
        
        PLUserManager *userManager = [PLUserManager initializeUserManager];
        [userManager setPlantReloadTrigger:YES];
        [userManager plantEditDict][@"Plant"] = model;
        [[self enclosingController] refreshData];
    }];
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the height for the cell
 */
+(CGFloat)heightForContent:(NSDictionary*)content {
    return 161+[super heightForContent:content];
}


@end
