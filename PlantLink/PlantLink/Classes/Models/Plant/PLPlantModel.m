//
//  PLPlantModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantModel.h"

#import "PLPlantMeasurementModel.h"
#import "PLPlantTypeModel.h"
#import "PLSoilModel.h"
#import "PLLinkModel.h"

@implementation PLPlantModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _name = dict[DC_Plant_Name];
        _plantTypeKey = [NSString stringWithFormat:@"%i",[dict[DC_Plant_PlantTypeKey] intValue]];
        _soilTypeKey = [NSString stringWithFormat:@"%i",[dict[DC_Plant_SoilTypeKey] intValue]];
        _environment = dict[DC_Plant_Environment];
        _pid = [NSString stringWithFormat:@"%lld",[dict[DC_Plant_PId] longLongValue]];
        _status = [dict[DC_Plant_Status] intValue];
        
        _upperMoistureThreshold = [dict[DC_Plant_UpperThreshold] floatValue];
        _lowerMoistureThreshold = [dict[DC_Plant_LowerThreshold] floatValue];
        
        if([dict[DC_Plant_Measurement] isKindOfClass:[NSArray class]]) {
            if([dict[DC_Plant_Measurement] count] > 0) _lastMeasurement = [PLPlantMeasurementModel initWithDictionary:dict[DC_Plant_Measurement][0]];
            else _lastMeasurement = NULL;
        }
        else _lastMeasurement = dict[DC_Plant_Measurement];
        
        if([dict[DC_Plant_Links] isKindOfClass:[NSArray class]]) _links = dict[DC_Plant_Links];
        else _links = dict[DC_Plant_Links];
        
        _created = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Plant_Created] intValue]];
        
        if([dict[DC_Plant_PlantType] isKindOfClass:[NSDictionary class]]) _plantType = [PLPlantTypeModel initWithDictionary:dict[DC_Plant_PlantType]];
        else _plantType = dict[DC_Plant_PlantType];
        
        if([dict[DC_Plant_SoilType] isKindOfClass:[NSDictionary class]]) _soilType = [PLSoilModel initWithDictionary:dict[DC_Plant_SoilType]];
        else _soilType = dict[DC_Plant_SoilType];
        
    }
    return self;
}

+(id)initWithDictionary:(NSDictionary*)dict {
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
    dict[DC_Plant_Status] = [NSNumber numberWithInt:_status];
    dict[DC_Plant_LowerThreshold] = [NSNumber numberWithFloat:_lowerMoistureThreshold];
    dict[DC_Plant_UpperThreshold] = [NSNumber numberWithFloat:_upperMoistureThreshold];
    
    if(_lastMeasurement) dict[DC_Plant_Measurement] = [_lastMeasurement copyWithZone:zone];
    else dict[DC_Plant_Measurement] = [NSNull null];
    
    dict[DC_Plant_Links] = [_links copyWithZone:zone];
    
    dict[DC_Plant_Created] = [NSNumber numberWithInt:[_created timeIntervalSince1970]];

    dict[DC_Plant_PlantType] = [_plantType copyWithZone:zone];
    dict[DC_Plant_SoilType] = [_soilType copyWithZone:zone];
    
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
        _status = [aDecoder decodeIntForKey:DC_Plant_Status];
        
        _lowerMoistureThreshold = [aDecoder decodeIntForKey:DC_Plant_LowerThreshold];
        _upperMoistureThreshold = [aDecoder decodeIntForKey:DC_Plant_UpperThreshold];
        
        _lastMeasurement = [aDecoder decodeObjectForKey:DC_Plant_Measurement];
        _links = [aDecoder decodeObjectForKey:DC_Plant_Links];
        
        _created = [aDecoder decodeObjectForKey:DC_Plant_Created];
        _plantType = [aDecoder decodeObjectForKey:DC_Plant_PlantType];
        _soilType = [aDecoder decodeObjectForKey:DC_Plant_SoilType];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_name forKey:DC_Plant_Name];
    [aCoder encodeObject:_plantTypeKey forKey:DC_Plant_PlantTypeKey];
    [aCoder encodeObject:_soilTypeKey forKey:DC_Plant_SoilTypeKey];
    [aCoder encodeObject:_environment forKey:DC_Plant_Environment];
    [aCoder encodeObject:_pid forKey:DC_Plant_PId];
    [aCoder encodeInt:_status forKey:DC_Plant_Status];
    
    if(_lastMeasurement) [aCoder encodeObject:_lastMeasurement forKey:DC_Plant_Measurement];
    else [aCoder encodeObject:_lastMeasurement forKey:DC_Plant_Measurement];
    
    [aCoder encodeInt:_lowerMoistureThreshold forKey:DC_Plant_LowerThreshold];
    [aCoder encodeInt:_upperMoistureThreshold forKey:DC_Plant_UpperThreshold];
    
    [aCoder encodeObject:_links forKey:DC_Plant_Links];
    
    [aCoder encodeObject:_created forKey:DC_Plant_Created];
    [aCoder encodeObject:_plantType forKey:DC_Plant_PlantType];
    [aCoder encodeObject:_soilType forKey:DC_Plant_SoilType];
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
