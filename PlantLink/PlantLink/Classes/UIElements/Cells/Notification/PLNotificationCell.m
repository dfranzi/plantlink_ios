//
//  PLNotificationCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationCell.h"

#import <QuartzCore/QuartzCore.h>

@implementation PLNotificationCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setBorderWidth:1.0];
        [self.layer setBorderColor:Color_CellBorder.CGColor];
        [self.layer setCornerRadius:5.0];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

#pragma mark -
#pragma mark Display Methods

+(CGFloat)heightForText:(NSString*)text {
    CGSize size = [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-LightItalic" size:16.0] constrainedToSize:CGSizeMake(280.0, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height;
}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary *)content {
    NSString *notification = content[NotificationInfo_Text];
    CGFloat height = [PLNotificationCell heightForText:notification];
    return CGSizeMake(297.0,10+20+height+10);
}

@end
