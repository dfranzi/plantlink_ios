//
//  PLUserModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLUserModel : AbstractModel

/**
 * The email address of the user (also the username)
 */
@property(nonatomic, strong, readonly) NSString *email;

/**
 * The phone number of the user
 */
@property(nonatomic, strong, readonly) NSString *phone;

/**
 * The full name of the user
 */
@property(nonatomic, strong, readonly) NSString *name;

/**
 * The zip code of the user
 */
@property(nonatomic, strong, readonly) NSString *zip;

/**
 * This iOS device tokens registered for the user
 */
@property(nonatomic, strong) NSArray *deviceTokens;

/**
 * Boolean indicating whether or not the user elected to recieve email alerts
 */
@property(nonatomic, assign, readonly) BOOL emailAlerts;

/**
 * Boolean indicating whether or not the user elected to recieve text alerts
 */
@property(nonatomic, assign, readonly) BOOL textAlerts;

/**
 * Boolean indicating whether or not the user elected to recieve push alerts
 */
@property(nonatomic, assign, readonly) BOOL pushAlerts;

@end
