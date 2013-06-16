//
//  PLPlantModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantModel.h"

#import "PLPlantMeasurementModel.h"
#import "PLValveModel.h"
#import "PLLinkModel.h"

@implementation PLPlantModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _name = dict[DC_Plant_Name];
        _plantTypeKey = dict[DC_Plant_PlantTypeKey];
        _soilTypeKey = dict[DC_Plant_SoilTypeKey];
        _environment = dict[DC_Plant_Environment];
        _pid = dict[DC_Plant_PId];
        _active = [dict[DC_Plant_Active] boolValue];
        
        
        
        if([dict[DC_Plant_Measurements] isKindOfClass:[NSArray class]]) _cachedMeasurements = [PLPlantMeasurementModel modelsFromArrayOfDictionaries:dict[DC_Plant_Measurements]];
        else _cachedMeasurements = dict[DC_Plant_Measurements];
        
        
        
        if([dict[DC_Plant_Valves] isKindOfClass:[NSArray class]]) _valves = dict[DC_Plant_Valves];
        else _valves = dict[DC_Plant_Valves];
        
        
        
        if([dict[DC_Plant_Links] isKindOfClass:[NSArray class]]) _links = dict[DC_Plant_Links];
        else _links = dict[DC_Plant_Links];
        
        
        
        _created = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Plant_Created] intValue]];
        
        
        if([dict[DC_Plant_Color] isKindOfClass:[NSString class]]) _color = [GeneralMethods colorFromHexString:dict[DC_Plant_Color]];
        else _color = dict[DC_Plant_Color];
        
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
    return [[PLPlantModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLPlantModel *model = [[PLPlantModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_Plant_Name] = [_name copyWithZone:zone];
    dict[DC_Plant_PlantTypeKey] = [_plantTypeKey copyWithZone:zone];
    dict[DC_Plant_SoilTypeKey] = [_soilTypeKey copyWithZone:zone];
    dict[DC_Plant_Environment] = [_environment copyWithZone:zone];
    dict[DC_Plant_PId] = [_pid copyWithZone:zone];
    dict[DC_Plant_Active] = [NSNumber numberWithBool:_active];
    
    dict[DC_Plant_Measurements] = [_cachedMeasurements copyWithZone:zone];
    dict[DC_Plant_Valves] = [_valves copyWithZone:zone];
    dict[DC_Plant_Links] = [_links copyWithZone:zone];
    
    dict[DC_Plant_Created] = [NSNumber numberWithInt:[_created timeIntervalSince1970]];
    dict[DC_Plant_Color] = [_color copyWithZone:zone];
    
    PLPlantModel *copy = [[PLPlantModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _name = [aDecoder decodeObjectForKey:DC_Plant_Name];
        _plantTypeKey = [aDecoder decodeObjectForKey:DC_Plant_PlantTypeKey];
        _soilTypeKey = [aDecoder decodeObjectForKey:DC_Plant_SoilTypeKey];
        _environment = [aDecoder decodeObjectForKey:DC_Plant_Environment];
        _pid = [aDecoder decodeObjectForKey:DC_Plant_PId];
        _active = [aDecoder decodeBoolForKey:DC_Plant_Active];
        
        _cachedMeasurements = [aDecoder decodeObjectForKey:DC_Plant_Measurements];
        _links = [aDecoder decodeObjectForKey:DC_Plant_Links];
        _valves = [aDecoder decodeObjectForKey:DC_Plant_Valves];
        
        _created = [aDecoder decodeObjectForKey:DC_Plant_Created];
        _color = [aDecoder decodeObjectForKey:DC_Plant_Color];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:DC_Plant_Name];
    [aCoder encodeObject:_plantTypeKey forKey:DC_Plant_PlantTypeKey];
    [aCoder encodeObject:_soilTypeKey forKey:DC_Plant_SoilTypeKey];
    [aCoder encodeObject:_environment forKey:DC_Plant_Environment];
    [aCoder encodeObject:_pid forKey:DC_Plant_PId];
    [aCoder encodeBool:_active forKey:DC_Plant_Active];
    
    [aCoder encodeObject:_cachedMeasurements forKey:DC_Plant_Measurements];
    [aCoder encodeObject:_links forKey:DC_Plant_Links];
    [aCoder encodeObject:_valves forKey:DC_Plant_Valves];
    
    [aCoder encodeObject:_created forKey:DC_Plant_Created];
    [aCoder encodeObject:_color forKey:DC_Plant_Color];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLPlantModel class]]) {
        PLPlantModel *other = (PLPlantModel*)object;
        return [[other pid] isEqualToString:_pid];
    }
    else return NO;
}

@end
