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
#define SettingsTitle_Tutorial @"Tutorial"
#define SettingsTitle_BugReport @"Bug Report"
#define SettingsTitle_ContactUs @"Contact Us"
#define SettingsTitle_Shop @"Shop"
#define SettingsTitle_Logout @"Logout"

#define SettingsCellTitles @[SettingsTitle_Notification, SettingsTitle_Tutorial, SettingsTitle_BugReport, SettingsTitle_ContactUs, SettingsTitle_Shop, SettingsTitle_Logout]

@implementation PLSettingsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *settings = [UIImage imageNamed:Image_Tab_Settings];
    UIImage *settingsHighlighted = [UIImage imageNamed:Image_Tab_SettingsHighlighted];
    [settingsTableView setBackgroundColor:Color_ViewBackground];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:settingsHighlighted withFinishedUnselectedImage:settings];
    
    if([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0000) [settingsTableView setFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
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
    [self performSegueWithIdentifier:Segue_ToContactUs sender:self];
}

-(void)shop {
    NSString *storeUrl = @"http://myplantlink.com/";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:storeUrl]];
}

-(void)logout {
    [sharedUser logout];
}

#pragma mark -
#pragma mark TableView Methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SettingsCellTitles count] + 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PLSettingsCell *cell = NULL;
    if(indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:Cell_SettingsImage forIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:Cell_Settings forIndexPath:indexPath];
        [cell setTitle:SettingsCellTitles[indexPath.row-1]];
    }
    [cell.contentView setBackgroundColor:tableView.backgroundColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0) return;

    int row = indexPath.row-1;
    if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Notification]) [self notifications];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Tutorial]) [self tutorial];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_BugReport]) [self bugReport];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_ContactUs]) [self contactUs];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Shop]) [self shop];
    else if([SettingsCellTitles[row] isEqualToString:SettingsTitle_Logout]) [self logout];
    
}


@end
