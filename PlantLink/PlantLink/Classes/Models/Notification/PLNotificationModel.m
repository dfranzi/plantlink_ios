//
//  PLNotificationModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 11/1/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationModel.h"

@implementation PLNotificationModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _hidden = [dict[DC_Notification_Hidden] boolValue];
        _nid = dict[DC_Notification_Key];
        _kind = dict[DC_Notification_Kind];
        _linkedObjectDictionary = dict[DC_Notification_LinkedObject];
        _markedAsRead = [dict[DC_Notification_MarkedAsRead] boolValue];
        _notificationTime = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Notification_NotificationTime] intValue]];
        _severity = dict[DC_Notification_Severity];
    }
    return self;
}

+(id)initWithDictionary:(NSDictionary*)dict {
    return [[PLNotificationModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLNotificationModel *model = [[PLNotificationModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_Notification_Hidden] = [NSNumber numberWithBool:_hidden];
    dict[DC_Notification_Key] = [_nid copyWithZone:zone];
    dict[DC_Notification_Kind] = [_kind copyWithZone:zone];
    dict[DC_Notification_LinkedObject] = [_linkedObjectDictionary copyWithZone:zone];
    dict[DC_Notification_MarkedAsRead] = [NSNumber numberWithBool:_markedAsRead];
    dict[DC_Notification_NotificationTime] = [NSNumber numberWithInt:[_notificationTime timeIntervalSince1970]];
    dict[DC_Notification_Severity] = [_severity copyWithZone:zone];
    
    PLNotificationModel *copy = [[PLNotificationModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _hidden = [aDecoder decodeBoolForKey:DC_Notification_Hidden];
        _nid = [aDecoder decodeObjectForKey:DC_Notification_Key];
        _kind = [aDecoder decodeObjectForKey:DC_Notification_Kind];
        _linkedObjectDictionary = [aDecoder decodeObjectForKey:DC_Notification_LinkedObject];
        _markedAsRead = [aDecoder decodeBoolForKey:DC_Notification_MarkedAsRead];
        _notificationTime = [aDecoder decodeObjectForKey:DC_Notification_NotificationTime];
        _severity = [aDecoder decodeObjectForKey:DC_Notification_Severity];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeBool:_hidden forKey:DC_Notification_Hidden];
    [aCoder encodeObject:_nid forKey:DC_Notification_Key];
    [aCoder encodeObject:_kind forKey:DC_Notification_Kind];
    [aCoder encodeObject:_linkedObjectDictionary forKey:DC_Notification_LinkedObject];
    [aCoder encodeBool:_markedAsRead forKey:DC_Notification_MarkedAsRead];
    [aCoder encodeObject:_notificationTime forKey:DC_Notification_NotificationTime];
    [aCoder encodeObject:_severity forKey:DC_Notification_Severity];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLNotificationModel class]]) {
        PLNotificationModel *other = (PLNotificationModel*)object;
        return [[other nid] isEqualToString:_nid];
    }
    else return NO;
}

@end
