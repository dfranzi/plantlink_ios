//
//  PLValveModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLValveModel : AbstractModel
// The serial number of the valve
@property(nonatomic, strong, readonly) NSString *serialNumber;

// The plant id the valve is associated with
@property(nonatomic, strong, readonly) NSString *plantKey;

@end
