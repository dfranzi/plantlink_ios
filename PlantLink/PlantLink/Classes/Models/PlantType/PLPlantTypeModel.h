//
//  PLPlantType.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLPlantTypeModel : AbstractModel

/**
 * The Oso assigned name of the plant type
 */
@property(nonatomic, strong, readonly) NSString *name;

/**
 * The server assigned key of the plant type
 */
@property(nonatomic, strong, readonly) NSString *key;

@end
