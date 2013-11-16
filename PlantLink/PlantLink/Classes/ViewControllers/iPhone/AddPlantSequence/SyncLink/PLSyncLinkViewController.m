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

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
}


#pragma mark -
#pragma mark Actions

-(void)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

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
    
    //[self performSegueWithIdentifier:Segue_ToAssociateValve sender:self];
}

-(void)foundLink:(PLLinkModel*)link {
    plantUpdateRequest = [[PLItemRequest alloc] init];
    NSMutableArray *linksArray = [NSMutableArray arrayWithArray:[_createdPlant links]];
    [linksArray addObject:[link key]];
    
    [plantUpdateRequest editPlant:[_createdPlant pid] paramDict:@{PostKey_LinkKeys : linksArray} withResponse:^(NSData *data, NSError *error) {
        NSLog(@"Response: %@",[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]);
        [sharedUser setPlantReloadTrigger:YES];
        [self dismissViewControllerAnimated:YES completion:^{}];
    }];
}

-(void)noLinkFound {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"No newly added link was found. Please try again." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

@end
