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
#import "PLUserModel.h"
#import "PLBaseStationModel.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PLSyncLinkViewController() {
@private
    PLItemRequest *linkRequest;
    PLItemRequest *baseStationDiscoveryRequest;
    PLItemRequest *plantUpdateRequest;
    MPMoviePlayerController *moviePlayer;
    
    int state;
}
@property(nonatomic, strong) NSArray *urlArray;

@end

@implementation PLSyncLinkViewController

/**
 * Sets the navigation icons and callback methods
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    state = 0;
    self.urlArray = @[@"http://oso.blob.core.windows.net/content/Batteries.mp4",
                      @"http://oso.blob.core.windows.net/content/Button%20Press.mp4",
                      @"http://oso.blob.core.windows.net/content/Green%20to%20Blue.mp4",
                      @"http://oso.blob.core.windows.net/content/Insert%20Link.mp4"];
    [self changeMoviePlayer];
}

/**
 * Starts the base station discovery when the view appears
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [moviePlayer setFullscreen:NO animated:NO];
    moviePlayer.view.frame = CGRectMake(0, 64, 320, 300);
    
    baseStationDiscoveryRequest = [[PLItemRequest alloc] init];
    [baseStationDiscoveryRequest getUserBaseStationsWithResponse:^(NSData *data, NSError *error) {
        NSArray *dataArr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSArray *baseStations = [PLBaseStationModel modelsFromArrayOfDictionaries:dataArr];
        
        if([baseStations count] == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"uh oh" message:@"No base stations found! Please register a base station" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        baseStationDiscoveryRequest = [[PLItemRequest alloc] init];
        PLBaseStationModel *baseStation = baseStations[0];
        [baseStationDiscoveryRequest putBaseStation:baseStation.serialNumber intoDiscoveryModeWithResponse:^(NSData *data, NSError *error) {
            
            if(error) {
                [self requestError:error];
                [self backPushed:nil];
                return;
            }
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if([dict isKindOfClass:[NSArray class]]) {
                if([self errorInRequestResponse:((NSArray*)dict)[0]]) {
                    [self backPushed:nil];
                    return;
                }
            }
            
        }];
    }];
}


/**
 * Cancels and still ongoing requests
 */
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if(linkRequest) [linkRequest cancel];
    if(baseStationDiscoveryRequest) [baseStationDiscoveryRequest cancel];
    if(plantUpdateRequest) [plantUpdateRequest cancel];
}

-(void)changeMoviePlayer {
    NSString *urlStr = self.urlArray[state];
    NSURL *url = [[NSURL alloc] initWithString:urlStr];
    if(moviePlayer) {
        [moviePlayer stop];
        [moviePlayer.view removeFromSuperview];
        moviePlayer = NULL;
    }
    
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    moviePlayer.shouldAutoplay = YES;
    moviePlayer.view.alpha = 1.0f;
    
    [self.view addSubview:moviePlayer.view];
    moviePlayer.view.frame = CGRectMake(0, 64, 320, 300);
    [moviePlayer play];
}

#pragma mark -
#pragma mark Actions

/**
 * Dismisses the view controller when the back button is pushed
 */
-(void)backPushed:(id)sender {
    if(state == 0) {
        [self dismissViewControllerAnimated:YES completion:^{}];
    }
    else {
        state--;
        [self changeMoviePlayer];
    }
    
    if(state == 0) {
        [self addLeftNavButtonWithImageNamed:Image_Navigation_DismissButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    }
}

/**
 * Attempts to match the link with a recently synced link to the base station
 */
-(void)nextPushed:(id)sender {
    if(state == 0) {
        [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(backPushed:)];
    }
    
    if(state < 3) {
        state++;
        [self changeMoviePlayer];
        return;
    }
    
    if(linkRequest) [linkRequest cancel];
    
    linkRequest = [[PLItemRequest alloc] init];
    [linkRequest getUserLinkesWithResponse:^(NSData *data, NSError *error) {
        if(error) {
            [self requestError:error];
            return;
        }
        
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
        
        if(error) {
            [self requestError:error];
            return;
        }
        
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
