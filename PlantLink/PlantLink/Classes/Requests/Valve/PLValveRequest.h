//
//  PLValveRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLValveRequest : AbstractRequest

-(id)initGetAllUserValvesRequest;
-(id)initAddUserValveRequest;
-(id)initDeleteValvePlantRequest;
-(id)initEditUserValveRequest;

@end
