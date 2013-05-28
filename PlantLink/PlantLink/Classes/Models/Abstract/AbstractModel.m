//
//  AbstractModel.m
//  Zealous Amoeba
//
//  Created by Zealous Amoeba on 5/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@implementation AbstractModel

-(id)initWithDictionary:(NSDictionary*)dict {
    if(self = [super init]) {
        
    }
    return self;
}

+(id)modelWithDictionary:(NSDictionary*)dict {
    return [[AbstractModel alloc] initWithDictionary:dict];
}

+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray {
    NSMutableArray *modelArray = [NSMutableArray array];
    for(NSDictionary *dict in dictArray) {
        AbstractModel *model = [[AbstractModel alloc] initWithDictionary:dict];
        [modelArray addObject:model];
    }
    return modelArray;
}

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone {
    AbstractModel *copy = [[AbstractModel alloc] initWithDictionary:@{}];
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
    return [object isKindOfClass:[AbstractModel class]];
}

@end
