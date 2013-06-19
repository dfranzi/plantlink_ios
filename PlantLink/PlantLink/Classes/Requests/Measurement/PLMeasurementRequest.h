//
//  PLMeasurementRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLMeasurementRequest : AbstractRequest
// The server assigned plant id of the plant
@property(nonatomic, strong) NSString *plantId;

/*
 * Retrieves all the latest measurements associated with the passed
 * in plant id for the plant of the currently logged in user
 */
-(id)initMeasurementRequestWithPlantId:(NSString*)plantId;

@end
