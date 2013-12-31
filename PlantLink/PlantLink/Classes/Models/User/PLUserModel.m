//
//  PLUserModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLUserModel.h"

@implementation PLUserModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        ZALog(@"%@",dict);
        
        _email = dict[DC_User_Email];
        _name = dict[DC_User_Name];
        _phone = dict[DC_User_Phone];
        _zip = dict[DC_User_Zipcode];
        
        _notificationTimes = dict[DC_User_NotificationTimes];
        
        if(![dict[DC_User_iOSTokens] isEqual:[NSNull null]]) _deviceTokens = @[];
        else _deviceTokens = dict[DC_User_iOSTokens];
        
        if(![dict[DC_User_EmailAlerts] isEqual:[NSNull null]]) _emailAlerts = [dict[DC_User_EmailAlerts] boolValue];
        else _emailAlerts = NO;
        
        if(![dict[DC_User_TextAlerts] isEqual:[NSNull null]])_textAlerts = [dict[DC_User_TextAlerts] boolValue];
        else _textAlerts = NO;
        
        if(![dict[DC_User_PushAlerts] isEqual:[NSNull null]]) _pushAlerts = [dict[DC_User_PushAlerts] boolValue];
        else _pushAlerts = NO;
    }
    return self;
}

+(id)initWithDictionary:(NSDictionary*)dict {
    return [[PLUserModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLUserModel *model = [[PLUserModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_User_Email] = [_email copyWithZone:zone];
    dict[DC_User_Name] = [_name copyWithZone:zone];
    dict[DC_User_Phone] = [_phone copyWithZone:zone];
    dict[DC_User_Zipcode] = [_zip copyWithZone:zone];
    
    dict[DC_User_NotificationTimes] = [_notificationTimes copyWithZone:zone];
    
    dict[DC_User_EmailAlerts] = [NSNumber numberWithBool:_emailAlerts];
    dict[DC_User_TextAlerts] = [NSNumber numberWithBool:_textAlerts];
    dict[DC_User_PushAlerts] = [NSNumber numberWithBool:_pushAlerts];
    
    PLUserModel *copy = [[PLUserModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _email = [aDecoder decodeObjectForKey:DC_User_Email];
        _name = [aDecoder decodeObjectForKey:DC_User_Name];
        _phone = [aDecoder decodeObjectForKey:DC_User_Phone];
        _zip = [aDecoder decodeObjectForKey:DC_User_Zipcode];
        
        _notificationTimes = [aDecoder decodeObjectForKey:DC_User_NotificationTimes];
        
        _emailAlerts = [aDecoder decodeBoolForKey:DC_User_EmailAlerts];
        _textAlerts = [aDecoder decodeBoolForKey:DC_User_TextAlerts];
        _pushAlerts = [aDecoder decodeBoolForKey:DC_User_PushAlerts];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_email forKey:DC_User_Email];
    [aCoder encodeObject:_name forKey:DC_User_Name];
    [aCoder encodeObject:_phone forKey:DC_User_Phone];
    [aCoder encodeObject:_zip forKey:DC_User_Zipcode];
    
    [aCoder encodeObject:_notificationTimes forKey:DC_User_NotificationTimes];
    
    [aCoder encodeBool:_emailAlerts forKey:DC_User_EmailAlerts];
    [aCoder encodeBool:_textAlerts forKey:DC_User_TextAlerts];
    [aCoder encodeBool:_pushAlerts forKey:DC_User_PushAlerts];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLUserModel class]]) {
        PLUserModel *other = (PLUserModel*)object;
        return [[other email] isEqualToString:_email];
    }
    else return NO;
}

@end
