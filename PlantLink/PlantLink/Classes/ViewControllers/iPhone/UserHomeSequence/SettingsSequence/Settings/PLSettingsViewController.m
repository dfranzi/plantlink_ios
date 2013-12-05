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

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *settings = [UIImage imageNamed:Image_Tab_Settings];
    UIImage *settingsHighlighted = [UIImage imageNamed:Image_Tab_SettingsHighlighted];
    [settingsCollectionView setBackgroundColor:Color_ViewBackground];
    
    stateDict = [NSMutableDictionary dictionary];
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:settingsHighlighted withFinishedUnselectedImage:settings];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [settingsCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
}


#pragma mark -
#pragma mark Action Methods

-(void)notifications {
    [self expandSection:State_Notifications];
}

-(void)account {
    [self expandSection:State_Account];
}

-(void)tutorial {
    [self performSegueWithIdentifier:Segue_ToTutorial sender:self];
}

-(void)bugReport {
    [self expandSection:State_BugReport];
}

-(void)contactUs {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:info@oso.tc"]];
}

-(void)shop {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLStr_Store]];
}

-(void)logout {
    [sharedUser logout];
}

-(void)update {
    for(PLSettingsCell *cell in settingsCollectionView.visibleCells) {
        [cell setStateDict:stateDict];
    }
}

#pragma mark -
#pragma mark TableView Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [SettingsCellTitles count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLSettingsCell *cell;
    
    if([SettingsCellTitles[indexPath.row] isEqualToString:SettingsTitle_Notification]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_SettingsNotification forIndexPath:indexPath];
    }
    else if([SettingsCellTitles[indexPath.row] isEqualToString:SettingsTitle_Account]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_SettingsAccount forIndexPath:indexPath];
    }
    else if([SettingsCellTitles[indexPath.row] isEqualToString:SettingsTitle_BugReport]) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_SettingsBugReport forIndexPath:indexPath];
    }
    else cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Settings forIndexPath:indexPath];
    
    [cell setStateDict:stateDict];
    [cell setTitle:SettingsCellTitles[indexPath.row]];
    [cell setLabel:SettingsCellLabels[indexPath.row]];
    [cell setParentViewController:self];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) return [PLSettingsNotificationCell sizeForContent:stateDict];
    else if(indexPath.row == 1) return [PLSettingsAccountCell sizeForContent:stateDict];
    else if(indexPath.row == 3) return [PLSettingsBugReportCell sizeForContent:stateDict];
    else return [PLSettingsCell sizeForContent:stateDict];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    int row = indexPath.row;
    if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Notification]) [self notifications];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Account]) [self account];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Tutorial]) [self tutorial];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_BugReport]) [self bugReport];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_ContactUs]) [self contactUs];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Shop]) [self shop];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Logout]) [self logout];
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
    
    CGPoint point = collectionView.contentOffset;
    [collectionView setContentOffset:CGPointMake(point.x, point.y-20) animated:YES];
}

#pragma mark -
#pragma mark Update Methods

-(void)closeSection:(NSString*)section {
    [stateDict removeObjectForKey:section];
    
    [self update];
    [self animateLayoutChanges:YES];
}

-(void)expandSection:(NSString*)section {
    stateDict[section] = @"Expand";
    
    [self update];
    [self animateLayoutChanges:YES];
}

-(void)animateLayoutChanges:(BOOL)animated {
    [settingsCollectionView performBatchUpdates:^{
        [settingsCollectionView.collectionViewLayout invalidateLayout];
        
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        [layout setItemSize:CGSizeMake(295, 110)];
//        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
//        [layout setSectionInset:UIEdgeInsetsMake(30, 0, 10, 0)];
//        [settingsCollectionView setCollectionViewLayout:layout animated:animated];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
