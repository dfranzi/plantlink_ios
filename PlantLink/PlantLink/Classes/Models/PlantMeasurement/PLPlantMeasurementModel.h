//
//  PLPlantMeasurementModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLPlantMeasurementModel : AbstractModel
// The associated plant id that the measurement was taken on
@property(nonatomic, strong, readonly) NSString *plantKey;

// The associated link id that the measurement was taken from
@property(nonatomic, strong, readonly) NSString *linkKey;

// The server assigned created date of the measurement
@property(nonatomic, strong, readonly) NSDate *created;



// The battery level indication as a float 0 - 100
@property(nonatomic, assign, readonly) float battery;

// The signal level indication as a float 0 - 100
@property(nonatomic, assign, readonly) float signal;

// The moisture level indication as a float 0 - 100
@property(nonatomic, assign, readonly) float moisture;

// The fuel level indication as a float 0 - 100
@property(nonatomic, assign, readonly) float plantFuelLevel;

@property(nonatomic, strong, readonly) NSDate *predictedWaterDate;


@end
