//
//  PLBaseStationModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLBaseStationModel.h"

@implementation PLBaseStationModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _serialNumber = dict[DC_BaseStation_SerialNumber];
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
    return [[PLBaseStationModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLBaseStationModel *model = [[PLBaseStationModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_BaseStation_SerialNumber] = [_serialNumber copyWithZone:zone];
    
    PLBaseStationModel *copy = [[PLBaseStationModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _serialNumber = [aDecoder decodeObjectForKey:DC_BaseStation_SerialNumber];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_serialNumber forKey:DC_BaseStation_SerialNumber];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLBaseStationModel class]]) {
        PLBaseStationModel *other = (PLBaseStationModel*)object;
        return [[other serialNumber] isEqualToString:_serialNumber];
    }
    else return NO;
}

@end
