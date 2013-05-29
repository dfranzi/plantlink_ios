//
//  PLPlantMeasurementModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLPlantMeasurementModel : AbstractModel
@property(nonatomic, strong, readonly) NSString *plantKey;
@property(nonatomic, strong, readonly) NSString *linkKey;
@property(nonatomic, strong, readonly) NSDate *created;
@property(nonatomic, strong, readonly) NSDate *timestamp;

@property(nonatomic, assign, readonly) float battery;
@property(nonatomic, assign, readonly) float signal;
@property(nonatomic, assign, readonly) float moisture;
@property(nonatomic, assign, readonly) BOOL isHealthy;

@end
