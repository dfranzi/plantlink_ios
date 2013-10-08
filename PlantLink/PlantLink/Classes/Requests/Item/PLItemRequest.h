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

-(void)getUserBaseStationsWithResponse:(void(^) (NSData *data, NSError *error))response;
-(void)addBaseStation:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;
-(void)removeBaseStation:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Measurement Methods

-(void)getMeasurementForPlant:(NSString*)plantId withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Plant Methods

-(void)getUserPlantsWithResponse:(void(^) (NSData *data, NSError *error))response;

-(void)addPlant:(NSString*)name type:(NSString*)type inSoil:(NSString*)soil withResponse:(void(^) (NSData *data, NSError *error))response;
-(void)removePlant:(NSString*)plantId withResponse:(void(^) (NSData *data, NSError *error))response;
-(void)editPlant:(NSString*)plantId paramDict:(NSDictionary*)dict withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Link Methods

-(void)getUserLinkesWithResponse:(void(^) (NSData *data, NSError *error))response;
-(void)getLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

-(void)registerLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;
-(void)removeLink:(NSString*)serial withResponse:(void(^) (NSData *data, NSError *error))response;

#pragma mark -
#pragma mark Type Methods

-(void)getPlantTypesWithResponse:(void(^) (NSData *data, NSError *error))response;
-(void)getSoilTypesWithResponse:(void(^) (NSData *data, NSError *error))response;


@end
