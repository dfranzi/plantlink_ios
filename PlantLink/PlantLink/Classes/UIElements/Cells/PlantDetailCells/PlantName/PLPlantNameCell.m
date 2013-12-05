//
//  PLPlantNameCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantNameCell.h"

#import "PLPlantModel.h"

@interface PLPlantNameCell() {
    BOOL isEditting;
    BOOL isShowingInfo;
}

@end

@implementation PLPlantNameCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        isEditting = NO;
        isShowingInfo = NO;
        
        [infoButton setAlpha:0.0f];
        [editButton setAlpha:0.0f];
    }
    return self;
}

#pragma mark -
#pragma mark Setters 

-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    
    [infoButton setAlpha:0.0f];
    [editButton setAlpha:0.0f];
    if([self model]) {
        [nameLabel setText:[[self model] name]];

        NSString *dateStr = [GeneralMethods stringFromDate:[[self model] created] withFormat:@"MMM, yyyy"];
        [activeOnLabel setText:[NSString stringWithFormat:@"Active since %@",dateStr]];
    }
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender {
    [_enclosingController dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)editPushed:(id)sender {
    isEditting = !isEditting;
    
    if(isEditting) {
        [editButton setImage:[UIImage imageNamed:Image_Pencil_Edit] forState:UIControlStateNormal];
        [editButton setFrame:CGRectMake(261-75, 0, 46+75, 41)];
    }
    else {
        [editButton setImage:[UIImage imageNamed:Image_Pencil_Gray] forState:UIControlStateNormal];
        [editButton setFrame:CGRectMake(261, 0, 46, 41)];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Plant_Edit object:[NSNumber numberWithBool:isEditting]];
}

-(IBAction)infoPushed:(id)sender {
    isShowingInfo = !isShowingInfo;
    
    if(isShowingInfo) [infoButton setImage:[UIImage imageNamed:Image_Info_On] forState:UIControlStateNormal];
    else [infoButton setImage:[UIImage imageNamed:Image_Info_Off] forState:UIControlStateNormal];
        
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Plant_Info object:[NSNumber numberWithBool:isShowingInfo]];
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 120+[super heightForContent:content];
}

@end
