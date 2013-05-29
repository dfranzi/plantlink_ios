//
//  PLProjectConstants.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "GeneralMethods.h"
#import "PLDesignConstants.h"

//Colors
#define Color_OsoGreen [UIColor colorWithRed:11.0/255.0 green:148.0/255.0 blue:68.0/255.0 alpha:1.0];
#define Color_OsoBlue [UIColor colorWithRed:0.0/255.0 green:31.0/255.0 blue:69.0/255.0 alpha:1.0];
#define Color_OsoBrown [UIColor colorWithRed:148.0/255.0 green:69.0/255.0 blue:11.0/255.0 alpha:1.0];

//URL Strings
#define URLStr_Base @"http://www.plantlink.com/api/v1"

#define URLStr_User @"/user"
#define URLStr_Authentication @"/auth"
#define URLStr_Logout @"/logout"
#define URLStr_PasswordReset @"/passwordReset?email=%@"

#define URLStr_BaseStation @"/baseStations"
#define URLStr_BaseStation_Delete @"/baseStations?serial=%@"

#define URLStr_SoilType @"/soilTypes"
#define URLStr_PlantType @"/plantTypes"

#define URLStr_Plant @"/plant"
#define URLStr_Plant_Id @"/plant?plant_id=%@"
#define URLStr_Valve @"/valve"

#define URLStr_Measurement @"/measurement"
#define URLStr_Measurement_Get @"/measurement?plant_id=%@"

//Post Keys
#define PostKey_Serial @"serial"

#define PostKey_Email @"email"
#define PostKey_Name @"name"
#define PostKey_ZipCode @"zip"
#define PostKey_Password @"password"

#define PostKey_PlantType @"plant_type"
#define PostKey_SoilType @"soil_type"
#define PostKey_LinkName @"link_name"
#define PostKey_LinkSerial @"link_serial"
#define PostKey_Color @"color"

//HTTP Codes
#define HTTP_Get @"GET"
#define HTTP_Post @"POST"
#define HTTP_Put @"PUT"
#define HTTP_Delete @"DELETE"

#define HTTP_Authentication_Format @"%@:%@"
#define HTTP_Authentication_Header @"Basic %@"
#define HTTP_Header_Authorization @"Authorization"

//Download Codes
#define DC_User_Email @"email"
#define DC_User_Phone @"phone"
#define DC_User_Name @"name"
#define DC_User_Zipcode @"zip"
#define DC_User_EmailAlerts @"email_alerts"
#define DC_User_TextAlerts @"text_alerts"
#define DC_User_PushAlerts @"push_alerts"

#define DC_BaseStation_SerialNumber @"serial"

#define DC_Soil_Key @"key"
#define DC_Soil_Name @"name"
#define DC_Soil_Created @"created"

#define DC_PlantType_Key @"key"
#define DC_PlantType_Name @"name"

#define DC_Valve_SerialNumber @"serial"
#define DC_Valve_PlantKey @"plant_key"
#define DC_Valve_Nickname @"nickname"

#define DC_Link_SerialNumber @"serial"

#define DC_Plant_Name @"name"
#define DC_Plant_Color @"color"
#define DC_Plant_PlantTypeKey @"plant_type_key"
#define DC_Plant_SoilTypeKey @"soil_type_key"
#define DC_Plant_Created @"created"
#define DC_Plant_Active @"active"
#define DC_Plant_PId @"id"
#define DC_Plant_Environment @"environment"
#define DC_Plant_Valves @"valves_key"
#define DC_Plant_Links @"links_key"
#define DC_Plant_Measurements @"measurement_cache"

#define DC_Measurement_PlantKey @"plant_key"
#define DC_Measurement_LinkKey @"link_key"
#define DC_Measurement_Created @"created"
#define DC_Measurement_Timestamp @"timestamp"
#define DC_Measurement_Moisture @"moisture"
#define DC_Measurement_Signal @"signal"
#define DC_Measurement_Battery @"battery"
#define DC_Measurement_IsHealthy @"is_healthy"

//Requests
typedef enum RequestTypes {
    Request_GetAllBaseStations,
    Request_AddBaseStation,
    Request_RemoveBaseStation,
    
    Request_GetMeasurements,
    
    Request_GetSoilTypes,
    Request_GetPlantTypes,
    
    Request_LoginUser,
    Request_LogoutUser,
    Request_RegisterUser,
    Request_PasswordReset,
    Request_GetUser,
    
    Request_GetAllPlants,
    Request_AddPlant,
    Request_EditPlant,
    Request_RemovePlant,
    
    Request_GetAllValves,
    Request_AddValve,
    Request_EditValve,
    Request_RemoveValve,
} RequestType;






