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
        _name = dict[DC_Soil_Name];
        _key = [NSString stringWithFormat:@"%i",[dict[DC_Soil_Key] intValue]];
    }
    return self;
}

+(id)initWithDictionary:(NSDictionary*)dict {
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
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_key forKey:DC_Soil_Key];
    [aCoder encodeObject:_name forKey:DC_Soil_Name];
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
