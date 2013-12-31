//
//  PLPlantModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@class PLPlantMeasurementModel;
@class PLPlantTypeModel;
@class PLSoilModel;
@interface PLPlantModel : AbstractModel

/**
 * The user assigned name of the plant
 */
@property(nonatomic, strong, readonly) NSString *name;

/**
 * The plant type model for the plant
 */
@property(nonatomic, strong, readonly) PLPlantTypeModel *plantType;

/**
 * The user assigned plant type key
 */
@property(nonatomic, strong, readonly) NSString *plantTypeKey;

/**
 * The soil type model for the plant
 */
@property(nonatomic, strong, readonly) PLSoilModel *soilType;

/**
 * The user assigned soil type key
 */
@property(nonatomic, strong, readonly) NSString *soilTypeKey;

/**
 * The user assigned environment the plant is growing in
 */
@property(nonatomic, strong, readonly) NSString *environment;

/**
 * The created date according to the server
 */
@property(nonatomic, strong, readonly) NSDate *created;

/**
 * The server assigned plant id in the datbase
 */
@property(nonatomic, strong, readonly) NSString *pid;

/**
 * The current moisture status of the plant
 */
@property(nonatomic, assign, readonly) int status;

/**
 * An array of PLPlantMeasurementModels indicating the most recent measurements
 */
@property(nonatomic, strong, readonly) PLPlantMeasurementModel *lastMeasurement;

/**
 * An array of link keys associated with the plant
 */
@property(nonatomic, strong, readonly) NSArray *links;

/**
 * The upper moisture threshold for the plant
 */
@property(nonatomic, assign, readonly) float upperMoistureThreshold;

/**
 * The lower moisture threshold for the plant
 */
@property(nonatomic, assign, readonly) float lowerMoistureThreshold;

@end
