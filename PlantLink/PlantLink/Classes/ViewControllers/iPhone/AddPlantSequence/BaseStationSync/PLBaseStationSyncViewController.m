//
//  PLBaseStationSyncViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLBaseStationSyncViewController.h"

@interface PLBaseStationSyncViewController() {
@private
}

@end

@implementation PLBaseStationSyncViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToPlantLinkSync];
}

@end
