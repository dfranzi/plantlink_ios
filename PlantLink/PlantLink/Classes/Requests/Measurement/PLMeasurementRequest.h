//
//  PLMeasurementRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLMeasurementRequest : AbstractRequest
@property(nonatomic, strong, readonly) NSString *plantId;

-(id)initMeasurementRequestWithPlantId:(NSString*)plantId;

@end
