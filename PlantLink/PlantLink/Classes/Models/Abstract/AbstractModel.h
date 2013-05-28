//
//  AbstractModel.h
//  Zealous Amoeba
//
//  Created by Zealous Amoeba on 5/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbstractModel : NSObject <NSCopying,NSCoding>

-(id)initWithDictionary:(NSDictionary*)dict;

+(id)modelWithDictionary:(NSDictionary*)dict;
+(NSMutableArray*)modelsFromArrayOfDictionaries:(NSArray*)dictArray;

#pragma mark -
#pragma mark NSCopying Methods

-(id)copyWithZone:(NSZone *)zone;

#pragma mark -
#pragma mark NSCoding Methods

-(id)initWithCoder:(NSCoder *)aDecoder;
-(void)encodeWithCoder:(NSCoder *)aCoder;

#pragma mark -
#pragma mark Equals Methods

-(BOOL)isEqual:(id)object;

@end
