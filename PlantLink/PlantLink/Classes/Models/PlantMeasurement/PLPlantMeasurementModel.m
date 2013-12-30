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
        _plantKey =  dict[DC_Measurement_PlantKey];
        _linkSerial = dict[DC_Measurement_LinkSerial];
        
        _created = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Measurement_Created] intValue]];
        
        if([dict[DC_Measurement_PredictedWaterDate] isEqual:[NSNull null]] || ([dict[DC_Measurement_PredictedWaterDate] isKindOfClass:[NSString class]] && [dict[DC_Measurement_PredictedWaterDate] isEqualToString:@"<null>"])) _predictedWaterDate = NULL;
        else _predictedWaterDate = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Measurement_PredictedWaterDate] intValue]];
        
        _moisture = [self adjsutedFloatValueForDictKey:DC_Measurement_Moisture inDict:dict];
        _signal = [self adjsutedFloatValueForDictKey:DC_Measurement_Signal inDict:dict];
        _battery = [self adjsutedFloatValueForDictKey:DC_Measurement_Battery inDict:dict];
        
    }
    return self;
}

-(float)adjsutedFloatValueForDictKey:(NSString*)key inDict:(NSDictionary*)dict {
    if([dict[key] isKindOfClass:[NSString class]] && ![dict[key] isEqualToString:@"<null>"]) return [dict[key] floatValue];
    else if([dict[key] isKindOfClass:[NSNumber class]]) return [dict[key] floatValue];
    else return 0.0f;
}

+(id)initWithDictionary:(NSDictionary*)dict {
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
    dict[DC_Measurement_PlantKey] = [NSString stringWithFormat:@"plant_%@_link_%@",[_plantKey copyWithZone:zone],[_linkSerial copyWithZone:zone]];
    
    dict[DC_Measurement_Created] = [NSNumber numberWithInt:[_created timeIntervalSince1970]];
    dict[DC_Measurement_PredictedWaterDate] = [NSNumber numberWithInt:[_predictedWaterDate timeIntervalSince1970]];
    
    dict[DC_Measurement_Moisture] = [NSNumber numberWithFloat:_moisture];
    dict[DC_Measurement_Signal] = [NSNumber numberWithFloat:_signal];
    dict[DC_Measurement_Battery] = [NSNumber numberWithFloat:_battery];
    
    PLPlantMeasurementModel *copy = [[PLPlantMeasurementModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _plantKey = [aDecoder decodeObjectForKey:DC_Measurement_PlantKey];
        _linkSerial = [aDecoder decodeObjectForKey:DC_Measurement_LinkSerial];
        _created = [aDecoder decodeObjectForKey:DC_Measurement_Created];
        _predictedWaterDate = [aDecoder decodeObjectForKey:DC_Measurement_PredictedWaterDate];
        
        _moisture = [aDecoder decodeFloatForKey:DC_Measurement_Moisture];
        _signal = [aDecoder decodeFloatForKey:DC_Measurement_Signal];
        _battery = [aDecoder decodeFloatForKey:DC_Measurement_Battery];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_plantKey forKey:DC_Measurement_PlantKey];
    [aCoder encodeObject:_linkSerial forKey:DC_Measurement_LinkSerial];
    [aCoder encodeObject:_created forKey:DC_Measurement_Created];
    [aCoder encodeObject:_predictedWaterDate forKey:DC_Measurement_PredictedWaterDate];
    
    [aCoder encodeFloat:_moisture forKey:DC_Measurement_Moisture];
    [aCoder encodeFloat:_signal forKey:DC_Measurement_Signal];
    [aCoder encodeFloat:_battery forKey:DC_Measurement_Battery];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLPlantMeasurementModel class]]) {
        PLPlantMeasurementModel *other = (PLPlantMeasurementModel*)object;
        return [[other created] isEqualToDate:_created] && [[other plantKey] isEqualToString:_plantKey] && [[other linkSerial] isEqualToString:_linkSerial];
    }
    else return NO;
}

@end
