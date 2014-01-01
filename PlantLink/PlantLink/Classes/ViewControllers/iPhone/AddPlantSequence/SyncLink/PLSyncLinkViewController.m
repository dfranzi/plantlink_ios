//
//  PLSyncLinkViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSyncLinkViewController.h"
#import "PLItemRequest.h"
#import "PLPlantModel.h"
#import "PLLinkModel.h"
#import "PLUserManager.h"

@interface PLSyncLinkViewController() {
@private
    PLItemRequest *linkRequest;
    PLItemRequest *plantUpdateRequest;
}

@end

@implementation PLSyncLinkViewController

/**
 * Sets the navigation icons and callback methods
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
}


#pragma mark -
#pragma mark Actions

/**
 * Dismisses the view controller when the back button is pushed
 */
-(void)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

/**
 * Attempts to match the link with a recently synced link to the base station
 */
-(void)nextPushed:(id)sender {
    if(linkRequest) [linkRequest cancel];
    
    linkRequest = [[PLItemRequest alloc] init];
    [linkRequest getUserLinkesWithResponse:^(NSData *data, NSError *error) {
        NSArray *linkData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *links = [PLLinkModel modelsFromArrayOfDictionaries:linkData];

        PLLinkModel *foundModel = NULL;
        NSDate *plantCreationData = [_createdPlant created];
        for(PLLinkModel *model in links) {
            NSDate *updated = [model lastSynced];
            if([updated compare:plantCreationData] == NSOrderedDescending) foundModel = model;
        }
        if(foundModel) [self foundLink:foundModel];
        else [self noLinkFound];
        
    }];
}

#pragma mark -
#pragma mark Link Methods

/**
 * Called when a link is found, and attached the link to the plant
 */
-(void)foundLink:(PLLinkModel*)link {
    plantUpdateRequest = [[PLItemRequest alloc] init];
    NSMutableArray *linksArray = [NSMutableArray arrayWithArray:[_createdPlant links]];
    [linksArray addObject:[link key]];
    
    [plantUpdateRequest editPlant:[_createdPlant pid] paramDict:@{PostKey_LinkKeys : linksArray} withResponse:^(NSData *data, NSError *error) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        if([dict isKindOfClass:[NSArray class]] && [self errorInRequestResponse:((NSArray*)dict)[0]]) return;
        else {
            [sharedUser setPlantReloadTrigger:YES];
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
    }];
}

/**
 * Shows an alert if no recently synced link is found
 */
-(void)noLinkFound {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"No newly added link was found. Please sync your Plant Link and try again." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

@end
