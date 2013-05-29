//
//  PLPlantType.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantType.h"

@implementation PLPlantType

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _name = dict[DC_PlantType_Name];
        _key = dict[DC_PlantType_Key];
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
    return [[PLPlantType alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLPlantType *model = [[PLPlantType alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_PlantType_Key] = [_key copyWithZone:zone];
    dict[DC_PlantType_Name] = [_name copyWithZone:zone];
    
    PLPlantType *copy = [[PLPlantType alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _key = [aDecoder decodeObjectForKey:DC_PlantType_Key];
        _name = [aDecoder decodeObjectForKey:DC_PlantType_Name];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_key forKey:DC_PlantType_Key];
    [aCoder encodeObject:_name forKey:DC_PlantType_Name];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLPlantType class]]) {
        PLPlantType *other = (PLPlantType*)object;
        return [[other key] isEqualToString:_key];
    }
    else return NO;
}

@end
