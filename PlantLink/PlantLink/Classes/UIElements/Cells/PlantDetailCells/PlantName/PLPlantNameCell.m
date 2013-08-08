//
//  PLPlantNameCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantNameCell.h"

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
    }
    return self;
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
    }
    else {
        [editButton setImage:[UIImage imageNamed:Image_Pencil_Gray] forState:UIControlStateNormal];
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
