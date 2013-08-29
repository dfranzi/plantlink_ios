//
//  PLNotificationViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationViewController.h"

#import "PLNotificationOptionButton.h"

#define Option_NotificationMorning @"morning"
#define Option_NotificationNoon @"noon"
#define Option_NotificationEvening @"evening"
#define Option_NotificationMidnight @"midnight"

@interface PLNotificationViewController() {
@private
    NSString *selectedNotificationOption;
}

@end

@implementation PLNotificationViewController

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)savePushed:(id)sender {
    [self backPushed:nil];
}


-(IBAction)morningPushed:(id)sender {
    [self resetButtons];
    [morningButton setBackgroundHighlight];
    selectedNotificationOption = Option_NotificationMorning;
}

-(IBAction)noonPushed:(id)sender {
    [self resetButtons];
    [noonButton setBackgroundHighlight];
    selectedNotificationOption = Option_NotificationNoon;
}

-(IBAction)eveningPushed:(id)sender {
    [self resetButtons];
    [eveningButton setBackgroundHighlight];
    selectedNotificationOption = Option_NotificationEvening;
}

-(IBAction)midnightPushed:(id)sender {
    [self resetButtons];
    [midnightButton setBackgroundHighlight];
    selectedNotificationOption = Option_NotificationMidnight;
}

#pragma mark -
#pragma mark Display Methods

-(void)resetButtons {
    NSArray *buttons = @[morningButton,noonButton,eveningButton,midnightButton];
    for(PLNotificationOptionButton *button in buttons) [button resetBackground];
}

@end
