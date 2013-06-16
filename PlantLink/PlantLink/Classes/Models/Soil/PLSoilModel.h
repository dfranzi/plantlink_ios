//
//  PLSoilModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLSoilModel : AbstractModel
// The server assigned key of the soil type
@property(nonatomic, strong, readonly) NSString *key;

// The Oso assigned name of the soil type
@property(nonatomic, strong, readonly) NSString *name;

// The server assgined date when the soil type was created
@property(nonatomic, strong, readonly) NSDate *created;

@end
