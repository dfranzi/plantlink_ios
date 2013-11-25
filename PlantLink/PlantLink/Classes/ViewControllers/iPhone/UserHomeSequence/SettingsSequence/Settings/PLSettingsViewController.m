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

@interface PLSettingsViewController() {
@private
}

@end

#define SettingsTitle_Notification @"Notifications"
#define SettingsTitle_Account @"Account"
#define SettingsTitle_Tutorial @"Tutorial"
#define SettingsTitle_BugReport @"Bug Report"
#define SettingsTitle_ContactUs @"Contact Us"
#define SettingsTitle_Shop @"Shop"
#define SettingsTitle_Logout @"Logout"

#define SettingsLabel_Notification @"Change the way you are notified"
#define SettingsLabel_Account @"Change the account email and password"
#define SettingsLabel_Tutorial @"View the plant link app tutorial"
#define SettingsLabel_BugReport @"Let us know about a possible bug"
#define SettingsLabel_ContactUs @"Contact Oso Simple Technologies"
#define SettingsLabel_Shop @"Buy extra plant links"
#define SettingsLabel_Logout @"Logout of the application"

#define SettingsCellTitles @[SettingsTitle_Notification, SettingsTitle_Account, SettingsTitle_Tutorial, SettingsTitle_BugReport, SettingsTitle_ContactUs, SettingsTitle_Shop, SettingsTitle_Logout]

#define SettingsCellLabels @[SettingsLabel_Notification, SettingsLabel_Account, SettingsLabel_Tutorial, SettingsLabel_BugReport, SettingsLabel_ContactUs, SettingsLabel_Shop, SettingsLabel_Logout]

#define State_Notifications @"Notifications Expanded"
#define State_BugReport @"Bug Report Expanded"
#define State_Contact @"Contact Expanded"

@implementation PLSettingsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *settings = [UIImage imageNamed:Image_Tab_Settings];
    UIImage *settingsHighlighted = [UIImage imageNamed:Image_Tab_SettingsHighlighted];
    [settingsCollectionView setBackgroundColor:Color_ViewBackground];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:settingsHighlighted withFinishedUnselectedImage:settings];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [settingsCollectionView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
}


#pragma mark -
#pragma mark Action Methods

-(void)notifications {
    [self performSegueWithIdentifier:Segue_ToNotifications sender:self];
}

-(void)tutorial {
    [self performSegueWithIdentifier:Segue_ToTutorial sender:self];
}

-(void)bugReport {
    [self performSegueWithIdentifier:Segue_ToBugReport sender:self];
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

#pragma mark -
#pragma mark TableView Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [SettingsCellTitles count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PLSettingsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_Settings forIndexPath:indexPath];
    [cell setTitle:SettingsCellTitles[indexPath.row]];
    [cell setLabel:SettingsCellLabels[indexPath.row]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [PLSettingsCell sizeForContent:@{}];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    int row = indexPath.row;
    if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Notification]) [self notifications];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Tutorial]) [self tutorial];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_BugReport]) [self bugReport];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_ContactUs]) [self contactUs];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Shop]) [self shop];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Logout]) [self logout];
    
}


@end
