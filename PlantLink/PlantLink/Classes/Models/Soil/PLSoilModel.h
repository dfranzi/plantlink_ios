//
//  PLSoilModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLSoilModel : AbstractModel
@property(nonatomic, strong, readonly) NSString *key;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSDate *created;

@end
