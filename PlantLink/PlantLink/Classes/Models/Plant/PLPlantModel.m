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

#warning Plant model and others have changed, make sure to fix before launch
-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _name = dict[DC_Plant_Name];
        _plantTypeKey = [NSString stringWithFormat:@"%i",[dict[DC_Plant_PlantTypeKey] intValue]];
        _soilTypeKey = [NSString stringWithFormat:@"%i",[dict[DC_Plant_SoilTypeKey] intValue]];
        _environment = dict[DC_Plant_Environment];
        _pid = [NSString stringWithFormat:@"%i",[dict[DC_Plant_PId] intValue]];
        
        ZALog(@"Dict: %@",dict);
        
        if([dict[DC_Plant_Measurement] isKindOfClass:[NSArray class]]) {
            if([dict[DC_Plant_Measurement] count] > 0) _lastMeasurement = [PLPlantMeasurementModel initWithDictionary:dict[DC_Plant_Measurement][0]];
            else _lastMeasurement = NULL;
        }
        else _lastMeasurement = dict[DC_Plant_Measurement];
        
        if([dict[DC_Plant_Links] isKindOfClass:[NSArray class]]) _links = dict[DC_Plant_Links];
        else _links = dict[DC_Plant_Links];
        
        _created = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Plant_Created] intValue]];
        
        #warning Color not implemented
        //if([dict[DC_Plant_Color] isKindOfClass:[NSString class]]) _color = [GeneralMethods colorFromHexString:dict
        //else _color = dict[DC_Plant_Color];
        
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
    
    if(_lastMeasurement) dict[DC_Plant_Measurement] = [_lastMeasurement copyWithZone:zone];
    else dict[DC_Plant_Measurement] = [NSNull null];
    
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
        
        _lastMeasurement = [aDecoder decodeObjectForKey:DC_Plant_Measurement];
        _links = [aDecoder decodeObjectForKey:DC_Plant_Links];
        
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
    
    if(_lastMeasurement) [aCoder encodeObject:_lastMeasurement forKey:DC_Plant_Measurement];
    else [aCoder encodeObject:_lastMeasurement forKey:DC_Plant_Measurement];
    
    [aCoder encodeObject:_links forKey:DC_Plant_Links];
    
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
