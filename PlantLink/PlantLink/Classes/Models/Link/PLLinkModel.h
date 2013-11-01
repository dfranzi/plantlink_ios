//
//  PLLinkModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLLinkModel : AbstractModel
// The serial number of the plant link
@property(nonatomic, strong, readonly) NSString *serialNumber;

@property(nonatomic, strong, readonly) NSDate *updated;

@property(nonatomic, strong, readonly) NSDate *lastSynced;

@property(nonatomic, strong, readonly) NSArray *plantKeys;

@end
