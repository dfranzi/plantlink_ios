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

@interface PLSettingsViewController() {
@private
    NSMutableDictionary *stateDict;
}

@end

@implementation PLSettingsViewController

/**
 * Sets the intial parameters and adjusts the collection view to the screen size
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarIconActive:Image_Tab_SettingsHighlighted passive:Image_Tab_Settings];
    
    [settingsCollectionView setBackgroundColor:Color_ViewBackground];
    stateDict = [NSMutableDictionary dictionary];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [settingsCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
}


#pragma mark -
#pragma mark Action Methods

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
#pragma mark TableView Methods

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
       !([rowTitle isEqualToString:SettingsTitle_BugReport] && [stateDict.allKeys containsObject:State_BugReport]) ) {
        
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        CGPoint point = collectionView.contentOffset;
        [collectionView setContentOffset:CGPointMake(point.x, point.y-20) animated:YES];
    }
    
    if([rowTitle isEqualToString:SettingsTitle_Notification]) [self notifications];
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

@end
