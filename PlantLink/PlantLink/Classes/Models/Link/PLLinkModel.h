//
//  PLLinkModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLLinkModel : AbstractModel

/**
 * The key of the link in the database
 */
@property(nonatomic, strong, readonly) NSNumber *key;

/**
 * The serial number of the plant link
 */
@property(nonatomic, strong, readonly) NSString *serialNumber;

/**
 * The date on which the plant link was first created
 */
@property(nonatomic, strong, readonly) NSDate *created;

/**
 * The date on which the plant link was previous updated
 */
@property(nonatomic, strong, readonly) NSDate *updated;

/**
 * The date on which the plant link was last synced
 */
@property(nonatomic, strong, readonly) NSDate *lastSynced;

/**
 * An array of plant keys that the link belongs to
 */
@property(nonatomic, strong, readonly) NSArray *plantKeys;

@end
