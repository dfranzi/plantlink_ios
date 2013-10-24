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
#warning Make sure no internet doesnt screw up the nullification of requests
#warning Make sure all onging requests are cancelled if view is left

//Constants
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


