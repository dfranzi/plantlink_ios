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
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Plant_Edit object:[NSNumber numberWithBool:isEditting]];
}

-(IBAction)infoPushed:(id)sender {
    isShowingInfo = !isShowingInfo;
    ZALog(@"Info pushed");
    [[NSNotificationCenter defaultCenter] postNotificationName:Notification_Plant_Info object:[NSNumber numberWithBool:isShowingInfo]];
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 107+[super heightForContent:content];
}

@end
