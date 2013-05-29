//
//  PLPlantModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLPlantModel : AbstractModel
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) UIColor *color;
@property(nonatomic, strong, readonly) NSString *plantTypeKey;
@property(nonatomic, strong, readonly) NSString *soilTypeKey;
@property(nonatomic, strong, readonly) NSString *environment;
@property(nonatomic, strong, readonly) NSDate *created;
@property(nonatomic, assign, readonly) BOOL active;
@property(nonatomic, strong, readonly) NSString *pid;

@property(nonatomic, strong, readonly) NSArray *cachedMeasurements;
@property(nonatomic, strong, readonly) NSArray *valves;
@property(nonatomic, strong, readonly) NSArray *links;

@end
