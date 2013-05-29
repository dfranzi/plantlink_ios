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
        _timestamp = [NSDate dateWithTimeIntervalSince1970:[dict[DC_Measurement_Timestamp] intValue]];
        
        _moisture = [dict[DC_Measurement_Moisture] floatValue];
        _signal = [dict[DC_Measurement_Signal] floatValue];
        _battery = [dict[DC_Measurement_Battery] floatValue];
        _isHealthy = [dict[DC_Measurement_IsHealthy] boolValue];
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
    
    dict[DC_Measurement_Created] = [[NSNumber numberWithInt:[_created timeIntervalSince1970]] stringValue];
    dict[DC_Measurement_Timestamp] = [[NSNumber numberWithInt:[_timestamp timeIntervalSince1970]] stringValue];
    
    dict[DC_Measurement_Moisture] = [NSNumber numberWithFloat:_moisture];
    dict[DC_Measurement_Signal] = [NSNumber numberWithFloat:_signal];
    dict[DC_Measurement_Battery] = [NSNumber numberWithFloat:_battery];
    dict[DC_Measurement_IsHealthy] = [NSNumber numberWithBool:_isHealthy];
    
    PLPlantMeasurementModel *copy = [[PLPlantMeasurementModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
    
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {

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
