//
//  PLPlantLinkSyncViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantLinkSyncViewController.h"

@interface PLPlantLinkSyncViewController() {
@private
}

@end

@implementation PLPlantLinkSyncViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToAddValveToPlant];
}

@end
