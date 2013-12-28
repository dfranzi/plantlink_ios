//
//  PLProjectConstants.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "GeneralConstants.h"
#import "PLDesignConstants.h"
#import "PLRequestConstants.h"

//Warning
#warning Switch downloadings plant and soil types to only add plant, use plant model data for plant detail
#warning Implement account and notification settings
#warning Add link to edit view
#warning Add push notificaiton registration and recieving code

//Constants
#define Constant_KeyChainItem @"Keychain-ZA-Oso"

#define Constant_LoginType_Login @"LoginType-Login"
#define Constant_LoginType_Setup @"LoginType-Setup"

#define Constant_SetupDict_Name @"name"
#define Constant_SetupDict_Email @"email"
#define Constant_SetupDict_Password @"password"
#define Constant_SetupDict_ZipCode @"zipcode"
#define Constant_SetupDict_SerialNumber @"serial"

//Defaults
#define Defaults_SavedEmail @"Defaults-SavedEmail"

//Segue
#define Segue_ToLogin @"toLoginView"
#define Segue_ToSerialInput @"toSerialInputView"
#define Segue_ToLocationInput @"toLocationInputView"
#define Segue_ToInformation @"toInformationView"
#define Segue_ToAddFirstPlant @"toAddFirstPlantView"
#define Segue_ToUserHome @"toUserHomeView"

#define Segue_ToAddPlantSequence @"toAddPlantSequence"
#define Segue_ToSyncLink @"toSyncLinkView"
#define Segue_ToAssociateValve @"toAssociateValveView"
#define Segue_ToCongratulations @"toCongratulationsView"

#define Segue_ToPlantDetail @"toPlantDetailView"

#define Segue_ToNotifications @"toNotificationsView"
#define Segue_ToNotificationSettings @"toNotificationSettingsView"

#define Segue_ToTutorial @"toTutorialView"
#define Segue_ToBugReport @"toBugReportView"
#define Segue_ToContactUs @"toContactUsView"

//Notifications
#define Notification_User_Logout @"User-Logout"

#define Notification_Plant_Edit @"Plant-Edit"
#define Notification_Plant_Info @"Plant-Info"

//Keys
#define API_Version @"1.0"

//PLant Info Text
#define InfoText_PlantName @""
#define InfoText_PlantDetail @"PlantLink uses these details to predict the appropriate moisture level of your plant"
#define InfoText_PlantMoisture @"The solid circle represents the current soil moisture level in your plant"
#define InfoText_PlantHistory @"This graph shows soil moisture level over the past 30 days"
#define InfoText_PlantSchedule @"This is the suggested date to water your plant"
#define InfoText_PlantLink @"Estimate battery life remaining and current signal strength of your sensor"
#define InfoText_PlantHelp @""

#define InfoText_All @[InfoText_PlantName, InfoText_PlantDetail, InfoText_PlantMoisture, InfoText_PlantHistory, InfoText_PlantSchedule, InfoText_PlantLink, InfoText_PlantHelp]


//Errors
#define Error_Auth @"InvalidBasicAuthParameter"
#define Error_NoAuth @"NoAuth"
#define Error_Generic @"GeneralError"

#define Error_Dict @{ Error_Auth : @"Invalid login information",\
                      Error_NoAuth : @"Invalid login information",\
                      Error_Generic : @"An error occured but could not be specified, we apologize"}

//Settings
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
#define State_Account @"Account Expanded"
