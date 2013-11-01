//
//  PLNotificationModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 11/1/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLNotificationModel : AbstractModel
@property(nonatomic, assign, readonly) BOOL hidden;
@property(nonatomic, strong, readonly) NSString *nid;
@property(nonatomic, strong, readonly) NSString *kind;

@property(nonatomic, assign, readonly) BOOL markedAsRead;
@property(nonatomic, strong, readonly) NSDate *notificationTime;
@property(nonatomic, strong, readonly) NSString *severity;

@property(nonatomic, strong, readonly) NSDictionary *linkedObjectDictionary;

@end
