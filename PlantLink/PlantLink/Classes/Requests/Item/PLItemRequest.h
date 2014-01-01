//
//  PLItemRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 9/28/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractBlockRequest.h"

@interface PLItemRequest : AbstractBlockRequest

#pragma mark -
#pragma mark Base Station Methods

/**
 * Returns all the base stations associated with the current user, calling the response block when done
 */
-(void)getUserBaseStationsWithResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Adds a base station with a given serial to the current user, calling the response block when done
 */
-(void)addBaseStation:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Removes the base station with a given serial, calling the response block when done
 */
-(void)removeBaseStation:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Measurement Methods

/**
 * Gets the measurement for a plant id, calling the response block when done
 */
-(void)getMeasurementForPlant:(NSString*)plantId withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Plant Methods

/**
 * Gets the users plant models an calls the response block when done
 */
-(void)getUserPlantsWithResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Get the plant as specified by the plant id
 */
-(void)getPlant:(NSString*)plantId withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Adds the plant with name, type, and soil to the current user, calling the response block when complete
 */
-(void)addPlant:(NSString*)name type:(NSString*)type inSoil:(NSString*)soil withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Removes the plant with the plant id and calls the response block when done
 */
-(void)removePlant:(NSString*)plantId withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Edits the plant with plantId updating the parameters in dict, calling the response block when done
 */
-(void)editPlant:(NSString*)plantId paramDict:(NSDictionary*)dict withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Link Methods

/**
 * Gets the users plant links calling the response block when complete
 */
-(void)getUserLinkesWithResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Gets a specific plant link with the given serial, calling the reponse block when done
 */
-(void)getLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Registers the link with the given serial to the currrent user, calling the response block when done
 */
-(void)registerLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Removes the link with a given serial from the current user, calling the response block when done
 */
-(void)removeLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Type Methods

/**
 * Gets all known plant types from the server, calling the response block when done
 */
-(void)getPlantTypesWithResponse:(void(^) (NSData *data, NSError *error))response;

/**
 * Gets all known soil types from the server, calling the response block when done
 */
-(void)getSoilTypesWithResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Feed Methods

/**
 * Gets all notifications for a given user, calling the response block when done
 */
-(void)getNotificationsWithResponse:(void(^) (NSData *data, NSError *error))response;


@end
