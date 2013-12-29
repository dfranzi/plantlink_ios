//
//  PLNotificationModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 11/1/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLNotificationModel : AbstractModel
/**
 * A boolean indicating whether the notification is hidden or not
 */
@property(nonatomic, assign, readonly) BOOL hidden;

/**
 * The notification id assigned by the server
 */
@property(nonatomic, strong, readonly) NSString *nid;

/**
 * The type of notification
 */
@property(nonatomic, strong, readonly) NSString *kind;

/**
 * A boolean indicating whether the notification has been read or not
 */
@property(nonatomic, assign, readonly) BOOL markedAsRead;

/**
 * The time the notification was first sent
 */
@property(nonatomic, strong, readonly) NSDate *notificationTime;

/**
 * The severity rating of the notification
 */
@property(nonatomic, strong, readonly) NSString *severity;

/**
 * The associated object with the notification (if any)
 */
@property(nonatomic, strong, readonly) NSDictionary *linkedObjectDictionary;

@end
