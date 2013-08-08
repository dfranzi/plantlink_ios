//
//  PLPlantMeasurementModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantMeasurementModel.h"

@implementation PLPlantMeasurementModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _plantKey = dict[DC_Measurement_PlantKey];
        _linkKey = dict[DC_Measurement_LinkKey];
        
        _created = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Measurement_Created] intValue]];
        _predictedWaterDate = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Measurement_PredictedWaterDate] intValue]];
        _moisture = [dict[DC_Measurement_Moisture] floatValue];
        _signal = [dict[DC_Measurement_Signal] floatValue];
        _battery = [dict[DC_Measurement_Battery] floatValue];
        _plantFuelLevel = [dict[DC_Measurement_PlantFuelLevel] floatValue];
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
    return [[PLPlantMeasurementModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLPlantMeasurementModel *model = [[PLPlantMeasurementModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_Measurement_PlantKey] = [_plantKey copyWithZone:zone];
    dict[DC_Measurement_LinkKey] = [_linkKey copyWithZone:zone];
    
    dict[DC_Measurement_Created] = [NSNumber numberWithInt:[_created timeIntervalSince1970]];
    dict[DC_Measurement_PredictedWaterDate] = [NSNumber numberWithInt:[_predictedWaterDate timeIntervalSince1970]];
    
    dict[DC_Measurement_Moisture] = [NSNumber numberWithFloat:_moisture];
    dict[DC_Measurement_Signal] = [NSNumber numberWithFloat:_signal];
    dict[DC_Measurement_Battery] = [NSNumber numberWithFloat:_battery];
    dict[DC_Measurement_PlantFuelLevel] = [NSNumber numberWithFloat:_plantFuelLevel];
    
    PLPlantMeasurementModel *copy = [[PLPlantMeasurementModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _plantKey = [aDecoder decodeObjectForKey:DC_Measurement_PlantKey];
        _linkKey = [aDecoder decodeObjectForKey:DC_Measurement_LinkKey];
        _created = [aDecoder decodeObjectForKey:DC_Measurement_Created];
        _predictedWaterDate = [aDecoder decodeObjectForKey:DC_Measurement_PredictedWaterDate];
        
        _moisture = [aDecoder decodeFloatForKey:DC_Measurement_Moisture];
        _signal = [aDecoder decodeFloatForKey:DC_Measurement_Signal];
        _battery = [aDecoder decodeFloatForKey:DC_Measurement_Battery];
        _plantFuelLevel = [aDecoder decodeFloatForKey:DC_Measurement_PlantFuelLevel];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_plantKey forKey:DC_Measurement_PlantKey];
    [aCoder encodeObject:_linkKey forKey:DC_Measurement_LinkKey];
    [aCoder encodeObject:_created forKey:DC_Measurement_Created];
    [aCoder encodeObject:_predictedWaterDate forKey:DC_Measurement_PredictedWaterDate];
    
    [aCoder encodeFloat:_moisture forKey:DC_Measurement_Moisture];
    [aCoder encodeFloat:_signal forKey:DC_Measurement_Signal];
    [aCoder encodeFloat:_battery forKey:DC_Measurement_Battery];
    [aCoder encodeFloat:_plantFuelLevel forKey:DC_Measurement_PlantFuelLevel];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLPlantMeasurementModel class]]) {
        PLPlantMeasurementModel *other = (PLPlantMeasurementModel*)object;
        return [[other created] isEqualToDate:_created] && [[other plantKey] isEqualToString:_plantKey] && [[other linkKey] isEqualToString:_linkKey];
    }
    else return NO;
}

@end
