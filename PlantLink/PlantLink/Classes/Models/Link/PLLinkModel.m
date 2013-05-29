//
//  PLLinkModel.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLinkModel.h"

@implementation PLLinkModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        _serialNumber = dict[DC_Link_SerialNumber];
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
    return [[PLLinkModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        PLLinkModel *model = [[PLLinkModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[DC_BaseStation_SerialNumber] = [_serialNumber copyWithZone:zone];
    
    PLLinkModel *copy = [[PLLinkModel alloc] initWithDictionary:dict];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super init]) {
        _serialNumber = [aDecoder decodeObjectForKey:DC_Link_SerialNumber];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_serialNumber forKey:DC_Link_SerialNumber];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    if([object isKindOfClass:[PLLinkModel class]]) {
        PLLinkModel *other = (PLLinkModel*)object;
        return [[other serialNumber] isEqualToString:_serialNumber];
    }
    else return NO;
}

@end
