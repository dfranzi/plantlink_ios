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
#warning Confirm caching works as intended
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
#define Segue_ToSoilTypeSelect @"toSoilTypeSelectView"
#define Segue_ToPlantNicknameSelect @"toPlantNicknameSelectView"
#define Segue_ToBaseStationSync @"toBaseStationSyncView"
#define Segue_ToPlantLinkSync @"toPlantLinkSyncView"
#define Segue_ToAddValveToPlant @"toAddValveToPlantView"

#define Segue_ToPlantDetail @"toPlantDetailView"

#define Segue_ToNotifications @"toNotificationsView"
#define Segue_ToTutorial @"toTutorialView"
#define Segue_ToBugReport @"toBugReportView"
#define Segue_ToContactUs @"toContactUsView"

//Notifications
#define Notification_User_UserRefreshed @"User-UserRefreshed"
#define Notification_User_UserRefreshFailed @"User-UserRefreshFailed"

#define Notification_User_TypesRefreshed @"User-TypesRefreshed"
#define Notification_User_TypesRefreshFailed @"User-TypesRefreshFailed"

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





