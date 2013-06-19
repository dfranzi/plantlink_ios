//
//  PLBaseStationRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLBaseStationRequest : AbstractRequest
// The serial number of the base station
@property(nonatomic, strong) NSString *serial;

/*
 * Gets all base stations associated with the current logged in user
 */
-(id)initGetBaseStationRequest;

/*
 * Adds a base station to the currently logged in user with the passed in
 * serial number
 */
-(id)initAddBaseStationRequestWithSerialNumber:(NSString*)serial;

/*
 * Removes a base station with the pass in serial number from the currently
 * logged in user
 */
-(id)initRemoveBaseStationRequestWithSerialNumber:(NSString*)serial;

@end
