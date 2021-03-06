//
//  PLDesignConstants.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <Foundation/Foundation.h>

//Cells
#define Cell_InformationCell @"informationCell"
#define Cell_PlantCell @"plantCell"
#define Cell_AddPlantCell @"addPlantCell"
#define Cell_PlantType @"plantTypeCell"
#define Cell_SoilType @"soilTypeCell"

#define Cell_PlantTitle @"plantTitleCell"
#define Cell_PlantDetail @"plantDetailCell"
#define Cell_PlantMoisture @"plantMoistureCell"
#define Cell_PlantHistory @"plantHistoryCell"
#define Cell_PlantSchedule @"plantScheduleCell"
#define Cell_PlantLinkDetail @"plantLinkDetailsCell"
#define Cell_PlantHelp @"plantHelpCell"

#define Cell_Notification @"notificationCell"
#define Cell_Edit @"editCell"

#define Cell_Schedule @"scheduleCell"
#define Cell_SettingsImage @"settingsImageCell"
#define Cell_Settings @"settingsCell"
#define Cell_SettingsNotification @"settingsNotificationCell"
#define Cell_SettingsAccount @"settingsAccountCell"
#define Cell_SettingsBugReport @"settingsBugReportCell"

#define Cell_PlantsAll @[Cell_PlantTitle, Cell_PlantDetail, Cell_PlantMoisture, Cell_PlantHistory, Cell_PlantSchedule, Cell_PlantLinkDetail]
#define Cell_Plants_NoWaterDate @[Cell_PlantTitle, Cell_PlantDetail, Cell_PlantMoisture, Cell_PlantHistory, Cell_PlantLinkDetail]
#define Cell_PlantsEdit @[Cell_PlantTitle, Cell_PlantDetail, Cell_PlantHistory, Cell_PlantLinkDetail]

//Colors
#define Color_PlantLinkGreen RGB(12.0,148.0,67.0)
#define Color_PlantLinkBrown RGB(122.0,93.0,60.0)
#define Color_PlantLinkBlue RGB(5.0,173.0,239.0)
#define Color_PlantLinkRed RGB(227.0,23.0,14.0)

#define Color_PlantLinkBlue_Dark RGB(0.0,133.0,199.0)
#define Color_PlantLinkRed_Dark RGB(187.0,0.0,0.0)

#define Color_PlantLinkTitle SHADE(82.0)
#define Color_PlantLinkSubtitle SHADE(214.0)
#define Color_PlantLinkBackground SHADE(242.0)

#define Color_ViewBackground RGB(255.0,255.0,255.0)

#define Color_TabBar_Background SHADE(250.0)
#define Color_MenuButton_Up RGB(75.0,176.0,227.0)
#define Color_MenuButton_Down RGB(0.0,166.0,217.0)

#define Color_CellBorder SHADE(220.0)
#define Color_Notification_OptionBackground SHADE(59.0)
#define Color_Notification_SelectedBackground RGB(57.0,182.0,84.0)
#define Color_TextField_Border RGB(215.0, 230.0, 226.0)

//Images
#define Image_Navigation_DismissButton @"xwhite.png"
#define Image_Navigation_BackButton @"arrowleft.png"
#define Image_Navigation_NextButton @"arrowright.png"

#define Image_Battery_Empty @"battery_0.png"
#define Image_Battery_Fourth @"battery_1.png"
#define Image_Battery_Half @"battery_2.png"
#define Image_Battery_ThreeFourth @"battery_3.png"
#define Image_Battery_Full @"battery_full.png"

#define Image_Network_Empty @"wifi_0.png"
#define Image_Network_Third @"wifi_1.png"
#define Image_Network_TwoThird @"wifi_2.png"
#define Image_Network_Full @"wifi_full.png"

#define Image_WaterCircle_Empty @"plantWaterCircle-Empty@2x.png"
#define Image_WaterCircle_Full @"plantWaterCircle-Full@2x.png"
#define Image_WaterCircle_Red @"plantWaterCircle-Red@2x.png"

#define Image_Info_On @"info-on.png"
#define Image_Info_Off @"info-off.png"
#define Image_Icon_X @"xicon.png"

#define Image_Headers_Link @"linkdetails.png"
#define Image_Headers_Moisture @"moisturehistory.png"
#define Image_Headers_Plant @"plantdetails.png"
#define Image_Headers_Soil @"soilmoisture.png"
#define Image_Headers_Schedule @"wateringschedule.png"

#define Image_Pencil_Edit @"pencil_edit.png"
#define Image_Pencil_Gray @"pencil_gray.png"
#define Image_Pencil_White @"pencil_edit.png"

#define Image_Icon_Add @"add.png"
#define Image_Icon_Remove @"remove.png"
#define Image_Icon_Trash @"trash.png"

#define Image_Link_HardwareError @"link_hardware_error.png"
#define Image_Link_Low_Battery @"link_low_battery.png"
#define Image_Link_Missing @"link_missing.png"
#define Image_Link_NoSoil @"link_no_soil.png"
#define Image_Link_Waiting @"link_waiting.png"
#define Image_Link_Watered @"link_watered.png"
#define Image_Link_No_Link @"link_not_added.png"


