//
//  PLPlantModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLPlantModel : AbstractModel

// The user assigned name of the plant
@property(nonatomic, strong, readonly) NSString *name;

// The user assigned color of the plant
@property(nonatomic, strong, readonly) UIColor *color;

// The user assigned plant type key
@property(nonatomic, strong, readonly) NSString *plantTypeKey;

// The user assigned soil type key
@property(nonatomic, strong, readonly) NSString *soilTypeKey;

// The user assigned environment the plant is growing in
@property(nonatomic, strong, readonly) NSString *environment;

// The created date according to the server
@property(nonatomic, strong, readonly) NSDate *created;

// Whether or not the plant is currently active
@property(nonatomic, assign, readonly) BOOL active;

// The server assigned plant id in the datbase
@property(nonatomic, strong, readonly) NSString *pid;


// An array of PLPlantMeasurementModels indicating the most recent measurements
@property(nonatomic, strong, readonly) NSArray *cachedMeasurements;

// An array of PLValveModels associated with the plant
@property(nonatomic, strong, readonly) NSArray *valves;

// An array of PLLinkModels associated with the plant
@property(nonatomic, strong, readonly) NSArray *links;

@end
