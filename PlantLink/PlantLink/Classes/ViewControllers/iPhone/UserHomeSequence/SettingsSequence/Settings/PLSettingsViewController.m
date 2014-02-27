//
//  PLSettingsViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsViewController.h"

#import "PLUserManager.h"
#import "PLSettingsCell.h"
#import "PLSettingsNotificationCell.h"
#import "PLSettingsAccountCell.h"
#import "PLSettingsBugReportCell.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PLSettingsViewController() {
@private
    NSMutableDictionary *stateDict;
    MPMoviePlayerController *moviePlayer;
}

@end

@implementation PLSettingsViewController

/**
 * Sets the intial parameters and adjusts the collection view to the screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [settingsCollectionView setBackgroundColor:Color_PlantLinkBackground];
    //[self setTabBarIconActive:Image_Tab_SettingsHighlighted passive:Image_Tab_Settings];
    
    stateDict = [NSMutableDictionary dictionary];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [settingsCollectionView setFrame:CGRectMake(0, 44, 320, self.view.frame.size.height-44)];
    else [settingsCollectionView setFrame:CGRectMake(0, 64, 320, self.view.frame.size.height-64-48)];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.navigationItem setTitle:@"Settings"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recievedNotification:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

#pragma mark -
#pragma mark Notification Methods

/*
 * Removes the movie player from the view when the movie is finished
 */
-(void)recievedNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:MPMoviePlayerPlaybackDidFinishNotification]) {
        [moviePlayer setFullscreen:NO animated:YES];
        [moviePlayer stop];
    }
}


#pragma mark -
#pragma mark Action Methods

/**
 * Shows the help video selector
 */
-(void)help {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Dismiss" destructiveButtonTitle:nil otherButtonTitles:@"Basestation Setup",@"PlantLink Batteries",@"PlantLink Press",@"Basestation Color Change",@"Insert PlantLink", nil];
    [actionSheet showInView:self.view];
}

/**
 * Expands the notification view
 */
-(void)notifications {
    [self expandSection:State_Notifications];
}

/**
 * Exapnds the account view
 */
-(void)account {
    [self expandSection:State_Account];
}

/**
 * Shows the bug report view
 */
-(void)bugReport {
    [self expandSection:State_BugReport];
}

/**
 * Opens the oso contact url
 */
-(void)contactUs {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLStr_Contact]];
}

/**
 * Opens the shop url
 */
-(void)shop {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLStr_Store]];
}

/**
 * Logs the user out
 */
-(void)logout {
    [sharedUser logout];
}

/**
 * Updates the cells with the current state dictionary
 */
-(void)update {
    for(PLSettingsCell *cell in settingsCollectionView.visibleCells) {
        [cell setStateDict:stateDict];
    }
}

#pragma mark -
#pragma mark Collection View Methods

/**
 * Returns the number of settings cell the display
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [SettingsCellTitles count];
}

/**
 * Returns the collection view cell and sets the cells parameters
 */
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLSettingsCell *cell;
    
    if([SettingsCellTitles[indexPath.row] isEqualToString:SettingsTitle_Notification]) cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_SettingsNotification forIndexPath:indexPath];
    else if([SettingsCellTitles[indexPath.row] isEqualToString:SettingsTitle_Account]) cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_SettingsAccount forIndexPath:indexPath];
    else if([SettingsCellTitles[indexPath.row] isEqualToString:SettingsTitle_BugReport]) cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_SettingsBugReport forIndexPath:indexPath];
    else cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Settings forIndexPath:indexPath];
    
    [cell setStateDict:stateDict];
    [cell setTitle:SettingsCellTitles[indexPath.row]];
    [cell setLabel:SettingsCellLabels[indexPath.row]];
    [cell setParentViewController:self];
    
    return cell;
}

/**
 * Returns the size of the collection view cell
 */
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    int row = indexPath.row;
    if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Notification]) return [PLSettingsNotificationCell sizeForContent:stateDict];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Account]) return [PLSettingsAccountCell sizeForContent:stateDict];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_BugReport]) return [PLSettingsBugReportCell sizeForContent:stateDict];
    else return [PLSettingsCell sizeForContent:stateDict];
}

/**
 * Performs the correct action when a cell is pressed, updating the collection view if necessary
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    int row = indexPath.row;
    NSString *rowTitle = SettingsCellTitles[row];
    
    if( !([rowTitle isEqualToString:SettingsTitle_Notification] && [stateDict.allKeys containsObject:State_Notifications]) &&
       !([rowTitle isEqualToString:SettingsTitle_Account] && [stateDict.allKeys containsObject:State_Account]) &&
       !([rowTitle isEqualToString:SettingsTitle_BugReport] && [stateDict.allKeys containsObject:State_BugReport]) &&
       !([rowTitle isEqualToString:SettingsTitle_Help])) {
        
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        CGPoint point = collectionView.contentOffset;
        [collectionView setContentOffset:CGPointMake(point.x, point.y-20) animated:YES];
    }

    if([rowTitle isEqualToString:SettingsTitle_Help]) [self help];
    else if([rowTitle isEqualToString:SettingsTitle_Notification]) [self notifications];
    else if([rowTitle isEqualToString:SettingsTitle_Account]) [self account];
    else if([rowTitle isEqualToString:SettingsTitle_BugReport]) [self bugReport];
    else if([rowTitle isEqualToString:SettingsTitle_ContactUs]) [self contactUs];
    else if([rowTitle isEqualToString:SettingsTitle_Shop]) [self shop];
    else if([rowTitle isEqualToString:SettingsTitle_Logout]) [self logout];
}

#pragma mark -
#pragma mark Update Methods

/**
 * Closes a given section
 */
-(void)closeSection:(NSString*)section {
    [self.view endEditing:YES];
    
    [stateDict removeObjectForKey:section];
    
    [self update];
    [self animateLayoutChanges:YES];
}

/**
 * Expands a given section
 */
-(void)expandSection:(NSString*)section {
    if(!stateDict[section]) {
        stateDict[section] = @"Expand";
    
        [self update];
        [self animateLayoutChanges:YES];
    }
}

/**
 * Sets the section to a specific state
 */
-(void)setSection:(NSString*)section toState:(NSString*)state {
    stateDict[section] = state;
    
    [self update];
    [self animateLayoutChanges:YES];
}

/**
 * Animates a layout change by invalidating the current collection view layout
 */
-(void)animateLayoutChanges:(BOOL)animated {
    [settingsCollectionView performBatchUpdates:^{
        [settingsCollectionView.collectionViewLayout invalidateLayout];
    } completion:^(BOOL finished) {}];
}

#pragma mark -
#pragma mark Touch Methods

/**
 * Dismisses the keyboard is the view is touched
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Action Sheet Methods

/*
 * Called when an item is selected on the action sheet, and starts the movie the button represents
 */

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [actionSheet dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if([actionSheet cancelButtonIndex] == buttonIndex) return;
    
    
    if(moviePlayer) [moviePlayer.view removeFromSuperview];
    
    NSArray *urls = @[@"http://oso.blob.core.windows.net/content/Basestation%20Setup.mp4",
                      @"http://oso.blob.core.windows.net/content/Batteries.mp4",
                      @"http://oso.blob.core.windows.net/content/Button%20Press.mp4",
                      @"http://oso.blob.core.windows.net/content/Green%20to%20Blue.mp4",
                      @"http://oso.blob.core.windows.net/content/Insert%20Link.mp4"];
    
    NSURL *url = [[NSURL alloc] initWithString:urls[buttonIndex]];
    
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
    moviePlayer.controlStyle = MPMovieControlStyleDefault;
    moviePlayer.shouldAutoplay = YES;
    moviePlayer.view.center = self.view.center;

    moviePlayer.view.alpha = 1.0f;
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}

@end
