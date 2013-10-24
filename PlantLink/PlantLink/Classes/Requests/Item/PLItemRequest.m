//
//  PLItemRequest.m
//  PlantLink
//
//  Created by Zealous Amoeba on 9/28/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLItemRequest.h"

@implementation PLItemRequest

-(void)addApiVersionToRequest:(NSMutableURLRequest*)request {
    [request addValue:API_Version forHTTPHeaderField:HTTP_Header_APIVersion];
}

#pragma mark -
#pragma mark Base Station Methods

-(void)getUserBaseStationsWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_BaseStation];
    
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)addBaseStation:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_BaseStation];
    
    [self getUrlStr:url withMethod:HTTP_Post withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:serial forKey:PostKey_Serial];
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)removeBaseStation:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_BaseStation_Delete,serial];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    
    [self getUrlStr:url withMethod:HTTP_Delete withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Measurement Methods

-(void)getMeasurementForPlant:(NSString*)plantId withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_Measurement_Get,plantId];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Plant Methods

-(void)getUserPlantsWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_Plant];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}


-(void)addPlant:(NSString*)name type:(NSString*)type inSoil:(NSString*)soil withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_Plant];
    [self getUrlStr:url withMethod:HTTP_Post withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[PostKey_Name] = name;
        dict[PostKey_PlantType] = type;
        dict[PostKey_SoilType] = soil;
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)removePlant:(NSString*)plantId withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_Plant_Id,plantId];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    [self getUrlStr:url withMethod:HTTP_Delete withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)editPlant:(NSString*)plantId paramDict:(NSDictionary*)dict withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_Plant_Id,plantId];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    [self getUrlStr:url withMethod:HTTP_Put withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        [request setHTTPBody:data];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Link Methods

-(void)getUserLinkesWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_Link];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)getLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_LinkSerial,serial];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)registerLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_LinkSerial,serial];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    [self getUrlStr:url withMethod:HTTP_Post withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)removeLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *param = [NSString stringWithFormat:URLStr_LinkSerial,serial];
    NSString *url = [URLStr_Base stringByAppendingString:param];
    [self getUrlStr:url withMethod:HTTP_Delete withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Type Methods

-(void)getPlantTypesWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_PlantType];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

-(void)getSoilTypesWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_SoilType];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

#pragma mark -
#pragma mark Feed Methods

-(void)getNotificationsWithResponse:(void(^) (NSData *data, NSError *error))response {
    NSString *url = [URLStr_Base stringByAppendingString:URLStr_Notifications];
    [self getUrlStr:url withMethod:HTTP_Get withEdit:^(NSMutableURLRequest *request) {
        [self addApiVersionToRequest:request];
    } andResponse:^(NSData *data, NSError *error) {
        response(data,error);
    }];
}

@end
