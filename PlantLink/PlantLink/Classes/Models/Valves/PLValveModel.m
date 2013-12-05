//
//  PLValveModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLValveModel.h"

@implementation PLValveModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _serialNumber = dict[DC_Valve_SerialNumber];
        _plantKey = dict[DC_Valve_PlantKey];
    }
    return self;
}

+(id)initWithDictionary:(NSDictionary*)dict {
    return [[PLValveModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLValveModel *model = [[PLValveModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_Valve_SerialNumber] = [_serialNumber copyWithZone:zone];
    dict[DC_Valve_PlantKey] = [_plantKey copyWithZone:zone];
    
    PLValveModel *copy = [[PLValveModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _serialNumber = [aDecoder decodeObjectForKey:DC_Valve_SerialNumber];
        _plantKey = [aDecoder decodeObjectForKey:DC_Valve_PlantKey];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_serialNumber forKey:DC_Valve_SerialNumber];
    [aCoder encodeObject:_plantKey forKey:DC_Valve_PlantKey];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLValveModel class]]) {
        PLValveModel *other = (PLValveModel*)object;
        return [[other serialNumber] isEqualToString:_serialNumber];
    }
    else return NO;
}

@end
