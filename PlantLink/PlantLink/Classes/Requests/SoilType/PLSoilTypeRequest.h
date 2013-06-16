//
//  PLSoilTypeRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLSoilTypeRequest : AbstractRequest

// Retrieves all known soil types from the server
-(id)initSoilTypeRequest;

@end
