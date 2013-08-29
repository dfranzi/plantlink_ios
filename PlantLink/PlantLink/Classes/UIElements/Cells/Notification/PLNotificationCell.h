//
//  PLNotificationCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractCLCell.h"

#define NotificationInfo_Text @"NotificationText"

@interface PLNotificationCell : AbstractCLCell {
    IBOutlet UILabel *dateLabel;
    IBOutlet UILabel *notificationLabel;
}

@end
