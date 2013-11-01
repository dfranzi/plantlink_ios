//
//  PLNotificationCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NotificationInfo_Text @"NotificationText"

@class PLNotificationModel;
@interface PLNotificationCell : UICollectionViewCell {
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *notificationLabel;
}
@property(nonatomic, strong) PLNotificationModel *notification;

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content;

@end
