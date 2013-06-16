//
//  PLPlantRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLPlantRequest : AbstractRequest
// The server assigned plant id
@property(nonatomic, strong, readonly) NSString *pid;

// The user assigned plant name
@property(nonatomic, strong, readonly) NSString *name;

// The user assigned plant type
@property(nonatomic, strong, readonly) NSString *plantType;

// The user assigned soil type
@property(nonatomic, strong, readonly) NSString *soilType;

// The user assigned link name
@property(nonatomic, strong) NSString *linkName;

// The serial number of the link
@property(nonatomic, strong) NSString *linkSerial;

// The user assigned link color
@property(nonatomic, strong) NSString *color;

/*
 * Retrieves all plants associated with the currently logged in user
 */
-(id)initGetAllUserPlantsRequest;

/*
 * Adds a plant to the currently logged in user with the passed in parameters (including any
 * optional parameters set before startRequest is called)
 */
-(id)initAddUserPlantRequestWithName:(NSString*)name plantType:(NSString*)plantType andSoilType:(NSString*)soilType;

/*
 * Removes the plant with the passed in plant id associated with the currently logged in user
 */
-(id)initRemoveUserPlantRequestWithPlantId:(NSString*)pid;

/*
 * Updates the plant information with the passed in parameters (and any optional parameters set before startRequest
 * is called) on the currently logged in user
 */
-(id)initEditUserPlantRequestWithName:(NSString*)name plantType:(NSString*)plantType andSoilType:(NSString*)soilType;

@end
