//
//  PLLinkModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLinkModel.h"

@implementation PLLinkModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _key = dict[DC_Link_Key];
        _serialNumber = dict[DC_Link_SerialNumber];
        _updated = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Link_Updated] intValue]];
        _created = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Link_Created] intValue]];
        _plantKeys = dict[DC_Link_PlantKeys];
        _lastSynced = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Link_LastSynced] intValue]];
    }
    return self;
}

+(id)initWithDictionary:(NSDictionary*)dict {
    return [[PLLinkModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLLinkModel *model = [[PLLinkModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_Link_Key] = [_key copyWithZone:zone];
    dict[DC_Link_SerialNumber] = [_serialNumber copyWithZone:zone];
    dict[DC_Link_Updated] = [NSNumber numberWithInt:[_updated timeIntervalSince1970]];
    dict[DC_Link_Created] = [NSNumber numberWithInt:[_created timeIntervalSince1970]];
    dict[DC_Link_PlantKeys] = [_plantKeys copyWithZone:zone];
    dict[DC_Link_LastSynced] = [NSNumber numberWithInt:[_lastSynced timeIntervalSince1970]];
    
    PLLinkModel *copy = [[PLLinkModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _key = [aDecoder decodeObjectForKey:DC_Link_Key];
        _serialNumber = [aDecoder decodeObjectForKey:DC_Link_SerialNumber];
        _updated = [aDecoder decodeObjectForKey:DC_Link_Updated];
        _created = [aDecoder decodeObjectForKey:DC_Link_Created];
        _plantKeys = [aDecoder decodeObjectForKey:DC_Link_PlantKeys];
        _lastSynced = [aDecoder decodeObjectForKey:DC_Link_LastSynced];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_key forKey:DC_Link_Key];
    [aCoder encodeObject:_serialNumber forKey:DC_Link_SerialNumber];
    [aCoder encodeObject:_updated forKey:DC_Link_Updated];
    [aCoder encodeObject:_created forKey:DC_Link_Created];
    [aCoder encodeObject:_plantKeys forKey:DC_Link_PlantKeys];
    [aCoder encodeObject:_lastSynced forKey:DC_Link_LastSynced];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLLinkModel class]]) {
        PLLinkModel *other = (PLLinkModel*)object;
        return [[other serialNumber] isEqualToString:_serialNumber];
    }
    else return NO;
}

@end
