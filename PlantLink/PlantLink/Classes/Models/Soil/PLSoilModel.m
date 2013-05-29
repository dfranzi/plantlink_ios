//
//  PLSoilModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSoilModel.h"

@implementation PLSoilModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _key = dict[DC_Soil_Key];
        _name = dict[DC_Soil_Name];
        _created = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Soil_Created] intValue]];
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
    return [[PLSoilModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLSoilModel *model = [[PLSoilModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_Soil_Key] = [_key copyWithZone:zone];
    dict[DC_Soil_Name] = [_name copyWithZone:zone];
    dict[DC_Soil_Created] = [NSNumber numberWithInt:[_created timeIntervalSince1970]];
    
    PLSoilModel *copy = [[PLSoilModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _key = [aDecoder decodeObjectForKey:DC_Soil_Key];
        _name = [aDecoder decodeObjectForKey:DC_Soil_Name];
        _created = [aDecoder decodeObjectForKey:DC_Soil_Created];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_key forKey:DC_Soil_Key];
    [aCoder encodeObject:_name forKey:DC_Soil_Name];
    [aCoder encodeObject:_created forKey:DC_Soil_Created];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLSoilModel class]]) {
        PLSoilModel *other = (PLSoilModel*)object;
        return [[other key] isEqualToString:_key];
    }
    else return NO;
}

@end
