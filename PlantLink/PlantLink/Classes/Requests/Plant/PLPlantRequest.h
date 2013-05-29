//
//  PLPlantRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLPlantRequest : AbstractRequest
@property(nonatomic, strong, readonly) NSString *pid;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSString *plantType;
@property(nonatomic, strong, readonly) NSString *soilType;
@property(nonatomic, strong) NSString *linkName;
@property(nonatomic, strong) NSString *linkSerial;
@property(nonatomic, strong) NSString *color;

-(id)initGetAllUserPlantsRequest;
-(id)initAddUserPlantRequestWithName:(NSString*)name plantType:(NSString*)plantType andSoilType:(NSString*)soilType;
-(id)initRemoveUserPlantRequestWithPlantId:(NSString*)pid;
-(id)initEditUserPlantRequestWithName:(NSString*)name plantType:(NSString*)plantType andSoilType:(NSString*)soilType;

@end
