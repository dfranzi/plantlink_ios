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
    
    @protected
    UIView *background;
    UIView *backdrop;
}

/**
 * Initializes the required labels for the cell programatically
 */
-(void)addLabels;

#pragma mark -
#pragma mark Notification Methods

/**
 * Sets the notification title, time, and sort order
 */
-(void)setNotificationTitle:(NSString*)title andTime:(NSDate*)time sortOrder:(int)order;

/**
 * Sets the display text for the notification
 */
+(NSString*)displayTextForNotification:(PLNotificationModel*)notification;

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content;

@end
