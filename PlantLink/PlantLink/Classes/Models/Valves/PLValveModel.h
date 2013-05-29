//
//  PLValveModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLValveModel : AbstractModel
@property(nonatomic, strong, readonly) NSString *serialNumber;
@property(nonatomic, strong, readonly) NSString *nickname;
@property(nonatomic, strong, readonly) NSString *plantKey;

@end
