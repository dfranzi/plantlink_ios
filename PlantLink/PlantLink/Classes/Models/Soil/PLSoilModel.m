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
        
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
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
    PLSoilModel *copy = [[PLSoilModel alloc] initWithDictionary:@{}];
    if(copy) return copy;
    else return NULL;
}

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder {
    //NSDictionary *dict = [aDecoder decodeObjectForKey:Coder_Key_Obj];
    if(self = [super init]) {}
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    //[aCoder encodeObject:@{} forKey:Coder_Key_Obj];
}

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object {
    return [object isKindOfClass:[PLSoilModel class]];
}

@end
