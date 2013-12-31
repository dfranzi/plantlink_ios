//
//  PLSettingsNotificationCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 11/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsNotificationCell.h"
#import "PLSettingsViewController.h"

#import "PLUserManager.h"
#import "PLUserModel.h"
#import "PLUserRequest.h"

@interface PLSettingsNotificationCell() {
@private
    PLUserRequest *notificationTimeRequest;
    PLUserRequest *notificationTypeRequest;
    
    BOOL morningNotifications;
    BOOL middayNotifications;
    BOOL afternoonNotifications;
    BOOL eveningNotifications;
    
    BOOL emailEnabled;
    BOOL pushEnabled;
    BOOL smsEnabled;
}

@end

@implementation PLSettingsNotificationCell

/**
 * Sets the intial parameters for the cell
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        morningNotifications = NO;
        middayNotifications = NO;
        afternoonNotifications = NO;
        eveningNotifications = NO;
        
        emailEnabled = NO;
        pushEnabled = NO;
        smsEnabled = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Override Methods

/**
 * Prevents the push down animation from happening if the cell is expanded
 */
-(void)setHighlighted:(BOOL)highlighted {
    if(![[self stateDict].allKeys containsObject:State_Notifications]) [super setHighlighted:highlighted];
}

/**
 * When the state dict is updated this method animates the expansion or compression of the cell
 */
-(void)setStateDict:(NSDictionary *)stateDict {
    [super setStateDict:stateDict];

    if([stateDict.allKeys containsObject:State_Notifications]) {
        [self updateInfo];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGSize size = [PLSettingsNotificationCell sizeForContent:stateDict];
            [background setFrame:CGRectMake(0, 0, size.width, size.height-2)];
            [backdrop setFrame:CGRectMake(0, 0, size.width, size.height+1)];
        } completion:^(BOOL finished) {}];
    }
    else {
        CGSize size = [PLSettingsNotificationCell sizeForContent:stateDict];
        [UIView animateWithDuration:0.3 animations:^{
            [background setFrame:CGRectMake(0, 0, size.width, size.height-2)];
            [backdrop setFrame:CGRectMake(0, 0, size.width, size.height+1)];
        }];
    }
    
    self.contentView.bounds = CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.frame.size.width, self.frame.size.height);
}

#pragma mark -
#pragma mark Action Methods

/**
 * Notification Time Buttons, update the notification time button image when pressed, and update the user on the server
 */

-(IBAction)morningPushed:(id)sender {
    morningNotifications = !morningNotifications;
    [self changeTimeButton:morningButton withBooleanFlag:morningNotifications updateServer:YES];
}

-(IBAction)middayPushed:(id)sender {
    middayNotifications = !middayNotifications;
    [self changeTimeButton:middayButton withBooleanFlag:middayNotifications updateServer:YES];
}

-(IBAction)afternoonPushed:(id)sender {
    afternoonNotifications = !afternoonNotifications;
    [self changeTimeButton:afternoonButton withBooleanFlag:afternoonNotifications updateServer:YES];
}

-(IBAction)eveningPushed:(id)sender {
    eveningNotifications = !eveningNotifications;
    [self changeTimeButton:eveningButton withBooleanFlag:eveningNotifications updateServer:YES];
}

/**
 * Notification Type Buttons, update the notification type button image when pressed, and update the user on the server
 */
-(IBAction)emailPushed:(id)sender {
    emailEnabled = !emailEnabled;
    [self changeTypeButton:emailButton withBooleanFlag:emailEnabled updateServer:YES];
}

-(IBAction)pushPushed:(id)sender {
    pushEnabled = !pushEnabled;
    [self changeTypeButton:pushButton withBooleanFlag:pushEnabled updateServer:YES];
}

-(IBAction)smsPushed:(id)sender {
    smsEnabled = !smsEnabled;
    [self changeTypeButton:smsButton withBooleanFlag:smsEnabled updateServer:YES];
}

/**
 * Navigation Buttons, compressed the cell by updating the parent
 */
-(IBAction)closePushed:(id)sender {
    [[self parentViewController] closeSection:State_Notifications];
}

/**
 * Called when the more button is pushed
 */
-(IBAction)morePushed:(id)sender {
    
}

#pragma mark -
#pragma mark Information Methods

/**
 * Updates both the notification times and types to the cached user, updating the view
 */
-(void)updateInfo {
    [self updateNotificationTimes];
    [self updateNotificationTypes];
}

/**
 * Updates the notification times to the cache user, and updates the view as necessary
 */
-(void)updateNotificationTimes {
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    PLUserModel *user = [sharedUser user];
    
    morningNotifications = [[user notificationTimes] containsObject:@9];
    middayNotifications = [[user notificationTimes] containsObject:@12];
    afternoonNotifications = [[user notificationTimes] containsObject:@17];
    eveningNotifications = [[user notificationTimes] containsObject:@20];
    
    [self changeTimeButton:morningButton withBooleanFlag:morningNotifications updateServer:NO];
    [self changeTimeButton:middayButton withBooleanFlag:middayNotifications updateServer:NO];
    [self changeTimeButton:afternoonButton withBooleanFlag:afternoonNotifications updateServer:NO];
    [self changeTimeButton:eveningButton withBooleanFlag:eveningNotifications updateServer:NO];
}

/**
 * Updates the notification type to the cache user, and updates the view as necessary
 */
-(void)updateNotificationTypes {
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    PLUserModel *user = [sharedUser user];
    
    emailEnabled = [user emailAlerts];
    pushEnabled = [user pushAlerts];
    smsEnabled = [user textAlerts];
    
    [self changeTypeButton:emailButton withBooleanFlag:emailEnabled updateServer:NO];
    [self changeTypeButton:pushButton withBooleanFlag:pushEnabled updateServer:NO];
    [self changeTypeButton:smsButton withBooleanFlag:smsEnabled updateServer:NO];
}

#pragma mark -
#pragma mark Request Methods

/**
 * Performs the notification time request, updating the server and refreshing the cached user
 */
-(void)notificationTimeRequest {
    notificationTimeRequest = [[PLUserRequest alloc] init];
    
    NSMutableArray *times = [NSMutableArray array];
    if(morningNotifications) [times addObject:@9];
    if(middayNotifications) [times addObject:@12];
    if(afternoonNotifications) [times addObject:@17];
    if(eveningNotifications) [times addObject:@20];
    
    [notificationTimeRequest updateUser:@{PostKey_Notifications : times} withResponse:^(NSData *data, NSError *error) {
        ZALog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        [sharedUser refreshData];
    }];
}

/**
 * Performs the notification type request, updating the server and refreshing the cached user
 */
-(void)notificationTypeRequest {
    notificationTypeRequest = [[PLUserRequest alloc] init];
    
    NSMutableDictionary *types = [NSMutableDictionary dictionary];
    if(emailEnabled) types[PostKey_EmailEnabled] = @YES;
    else types[PostKey_EmailEnabled] = @NO;
    
    if(pushEnabled) types[PostKey_PushEnabled] = @YES;
    else types[PostKey_PushEnabled] = @NO;
    
    if(smsEnabled) types[PostKey_SMSEnabled] = @YES;
    else types[PostKey_SMSEnabled] = @NO;
    
    [notificationTypeRequest updateUser:types withResponse:^(NSData *data, NSError *error) {
        ZALog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        [sharedUser refreshData];
    }];
}

#pragma mark -
#pragma mark Display Methods

/**
 * Changes the button type for a button depending on the boolean flag
 */
-(void)updateButton:(UIButton*)button withBooleanFlag:(BOOL)flag {
    NSString *imageName = @"checkmarkGray.png";
    if(flag) imageName = @"checkmarkBlue.png";
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

/**
 * Changes the button type for a notification time button, and updates the server if the flag is set
 */
-(void)changeTimeButton:(UIButton*)button withBooleanFlag:(BOOL)flag updateServer:(BOOL)update {
    [self updateButton:button withBooleanFlag:flag];
    if(update) [self notificationTimeRequest];
}

/**
 * Changes the button type for a notification type button, and updates the server if the flag is set
 */
-(void)changeTypeButton:(UIButton*)button withBooleanFlag:(BOOL)flag updateServer:(BOOL)update {
    [self updateButton:button withBooleanFlag:flag];
    if(update) [self notificationTypeRequest];
}

#pragma mark -
#pragma mark Size Methods

/**
 * Retunrs the size for the cell in either the compressed or expanded state
 */
+(CGSize)sizeForContent:(NSDictionary*)content {
    if([content.allKeys containsObject:State_Notifications]) return CGSizeMake(295, 378);
    return CGSizeMake(295, 110);
}

@end
