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
    UILabel *nameLabel;
    UILabel *dateLabel;
    UILabel *dayLabel;
    
    UIView *separatorView;
}

#pragma mark -
#pragma mark Notification Methods

/**
 *
 */
-(void)setNotificationTitle:(NSString*)title andTime:(NSDate*)time sortOrder:(int)order;

/**
 *
 */
+(NSString*)displayTextForNotification:(PLNotificationModel*)notification;

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content;

@end
