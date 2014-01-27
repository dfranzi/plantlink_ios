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
#import "PLMenuButton.h"

@interface PLSettingsNotificationCell() {
@private
    PLUserRequest *smsRequest;
    PLUserRequest *notificationTimeRequest;
    PLUserRequest *notificationTypeRequest;
    
    BOOL morningNotifications;
    BOOL middayNotifications;
    BOOL afternoonNotifications;
    BOOL eveningNotifications;
    
    BOOL emailEnabled;
    BOOL pushEnabled;
    BOOL smsEnabled;
    
    BOOL smsShown;
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
        
        smsShown = YES;
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
        
        if([stateDict[State_Notifications] isEqualToString:@"ExpandMost"]) [self setButtonsToSMSMode];
        else [self setButtonsToStandardMode];
    }
    else {
        [self setButtonsToStandardMode];
        
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
 * Called when the more button is pushed, either expanding the view or showing the add number alert
 */
-(IBAction)morePushed:(id)sender {
    if(!smsShown) [[self parentViewController] setSection:State_Notifications toState:@"ExpandMost"];
    else {
        UIAlertView *smsAlert = [[UIAlertView alloc] initWithTitle:@"Add Number" message:@"Please enter your phone number using only numbers." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Submit", nil];
        [smsAlert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [smsAlert show];
    }
}

#pragma mark -
#pragma mark Alert Methods

/**
 * Called when a alert button is clicked, trying to add the number if it is all numeric characters
 */
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if([alertView cancelButtonIndex] != buttonIndex) {
        NSString *phoneNum = [[alertView textFieldAtIndex:0] text];
        if([phoneNum rangeOfCharacterFromSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]].location == NSNotFound) {
            [self addSmsNumberRequest:phoneNum];
        }
        else {
            UIAlertView *invalidPhoneAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Number:" message:@"The number you have entered is invalid. Please try again." delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [invalidPhoneAlert show];
        }
    }
}

#pragma mark -
#pragma mark Display Methods

/**
 * Sets the buttons and view to the standard view mode
 */
-(void)setButtonsToStandardMode {
    smsShown = NO;

    [UIView animateWithDuration:0.3 animations:^{
        [closeButton setFrame:CGRectMake(20.0f, 326.0f, 113.0f, 40.0f)];
        [moreButton setFrame:CGRectMake(164.0f, 326.0f, 113.0f, 40.0f)];
    } completion:^(BOOL finished) {
        [moreButton updateButtonAppearance];
        [closeButton updateButtonAppearance];
    }];
    
    [moreButton setTitle:@"More" forState:UIControlStateNormal];
    [self hideSmsInfo];
}

/**
 * Sets the buttons and view to the sms view mode
 */
-(void)setButtonsToSMSMode {
    smsShown = YES;
    
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    NSNumber *offset = [NSNumber numberWithInt:40*[[[sharedUser user] smsNumbers] count]];
    
    //No idea why this is needed, more button refused to changed frame without this call....
    [self performSelector:@selector(adjustButtons:) withObject:offset afterDelay:0.0];
    
    [moreButton setTitle:@"Add Number" forState:UIControlStateNormal];
    [self showSmsInfo];
}

/**
 * Adjusts the buttons with a given offset for the sms view mode
 */
-(void)adjustButtons:(NSNumber*)offset {
    int adj = [offset intValue];
    if(adj > 0) adj += 20;
    
    [UIView animateWithDuration:0.3 animations:^{
        [closeButton setFrame:CGRectMake(20.0f, 376.0f+adj, 257.0f, 40.0f)];
        [moreButton setFrame:CGRectMake(20.0f, 326.0f+adj, 257.0f, 40.0f)];
    } completion:^(BOOL finished) {
        [moreButton updateButtonAppearance];
        [closeButton updateButtonAppearance];
    }];
}

/**
 * Adds a number with an sms dict to the view, creating the sms view and animating the view change
 */
-(void)addNumberWithDict:(NSDictionary*)dict {
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    [[[sharedUser user] smsNumbers] addObject:dict];
    
    int index = 0;
    for(UIView *smsView in self.contentView.subviews) {
        if(smsView.tag == 3) index++;
    }
    
    PLSmsView *view = [[PLSmsView alloc] initWithFrame:CGRectMake(20.0f, 326.0f+index*40.0f, 257.0f, 40.0f)];
    [view setDict:dict];
    [view setDelegate:self];
    view.tag = 3;
    [view setAlpha:0.0f];

    if(index % 2 == 0) [view setBackgroundColor:SHADE(255.0*0.95)];
    else [view setBackgroundColor:SHADE(255.0*0.90)];
    
    [self.contentView insertSubview:view belowSubview:closeButton];
    
    //No idea why this is needed, more button refused to changed frame without this call....
    [self performSelector:@selector(adjustButtons:) withObject:[NSNumber numberWithInt:40*(index+1)] afterDelay:0.0];
    
    [UIView animateWithDuration:0.3 animations:^{
        [view setAlpha:1.0f];
    }];
    
    [[self parentViewController] setSection:State_Notifications toState:@"ExpandMost"];
}

/**
 * Removes a number with a given number key, animating the view updates
 */
-(void)removeNumberWithKey:(NSString*)key {
    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    NSMutableArray *newSms = [NSMutableArray array];
    for(NSDictionary *dict in [[sharedUser user] smsNumbers]) {
        NSString *dictKey = [NSString stringWithFormat:@"%llu",[dict[@"key"] longLongValue]];
        if(![dictKey isEqualToString:key]) {
            [newSms addObject:dict];
        }
    }

    [[sharedUser user] setSmsNumbers:newSms];
    [UIView animateWithDuration:0.3 animations:^{
        for(UIView *smsView in self.contentView.subviews) {
            if(smsView.tag == 3) [smsView setAlpha:0.0f];
        }
    } completion:^(BOOL finished) {
        [self updateSMSInformation];
        for(UIView *smsView in self.contentView.subviews) {
            if(smsView.tag == 3) [smsView setAlpha:0.0f];
        }
        [self showSmsInfo];
    }];
    
    [[self parentViewController] setSection:State_Notifications toState:@"ExpandMost"];
}

#pragma mark -
#pragma mark Information Methods

/**
 * Updates both the notification times and types to the cached user, updating the view
 */
-(void)updateInfo {
    [self updateNotificationTimes];
    [self updateNotificationTypes];
    [self updateSMSInformation];
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

/**
 * Removes the sms views and adds new ones with the current sms information
 */
-(void)updateSMSInformation {
    for(UIView *view in self.contentView.subviews) {
        if(view.tag == 3) [view removeFromSuperview];
    }

    PLUserManager *sharedUser = [PLUserManager initializeUserManager];
    int index = 0;
    for(NSDictionary *dict in [[sharedUser user] smsNumbers]) {
        PLSmsView *view = [[PLSmsView alloc] initWithFrame:CGRectMake(20.0f, 326.0f+index*40.0f, 257.0f, 40.0f)];
        [view setDict:dict];
        [view setDelegate:self];
        view.tag = 3;

        if(index % 2 == 0) [view setBackgroundColor:SHADE(255.0*0.95)];
        else [view setBackgroundColor:SHADE(255.0*0.90)];
        
        [self.contentView insertSubview:view belowSubview:closeButton];
        
        index++;
    }
}

/**
 * Animates in the sms information
 */
-(void)showSmsInfo {
    [UIView animateWithDuration:0.3 animations:^{
        for(UIView *view in self.contentView.subviews) {
            if(view.tag == 3) [view setAlpha:1.0f];
        }
    }];
}

/**
 * Animates out the sms information
 */
-(void)hideSmsInfo {
    [UIView animateWithDuration:0.3 animations:^{
        for(UIView *view in self.contentView.subviews) {
            if(view.tag == 3) [view setAlpha:0.0f];
        }
    }];
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
        if(error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"uh oh" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        [sharedUser refreshUserData];
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
        if(error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"uh oh" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        [sharedUser refreshUserData];
    }];
}

/**
 * Performs the add sms number request for a given number
 */
-(void)addSmsNumberRequest:(NSString*)number {
    __block PLSettingsNotificationCell *cell = self;
    
    smsRequest = [[PLUserRequest alloc] init];
    [smsRequest addSmsNumber:number withResponse:^(NSData *data, NSError *error) {
        if(error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"uh oh" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        if([dict isKindOfClass:[NSArray class]]) {
            if([cell errorInRequestResponse:((NSArray*)dict)[0]]) {}
            else [cell addNumberWithDict:dict];
        }
        else [cell addNumberWithDict:dict];
    }];
}

/**
 * Performs the remove sms number request for a given number
 */
-(void)removeSmsNumberRequestWithKey:(NSString*)key {
    smsRequest = [[PLUserRequest alloc] init];
    [smsRequest removeSmsNumberWithKey:key withResponse:^(NSData *data, NSError *error) {
        if(error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"uh oh" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

        if([dict isKindOfClass:[NSArray class]]) {
            if([(NSArray*)dict count] && [self errorInRequestResponse:((NSArray*)dict)[0]]) {}
            else [self removeNumberWithKey:key];
        }
        else [self removeNumberWithKey:key];
    }];
}

#pragma mark -
#pragma mark SMS Delegate Methods

/**
 * Called when the trash icon was pushed on a sms view, including the numbers sms dict
 */
-(void)trashPushed:(NSDictionary *)smsDict {
    NSString *key = [NSString stringWithFormat:@"%llu",[smsDict[@"key"] longLongValue]];
    [self removeSmsNumberRequestWithKey:key];
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
    if([content.allKeys containsObject:State_Notifications] && [content[State_Notifications] isEqualToString:@"Expand"]) return CGSizeMake(295, 378);
    else if([content.allKeys containsObject:State_Notifications] && [content[State_Notifications] isEqualToString:@"ExpandMost"]) {
        PLUserManager *sharedUser = [PLUserManager initializeUserManager];
        int offset = [[[sharedUser user] smsNumbers] count]*40.0;
        return CGSizeMake(295, 378+90+offset);
    }
    else return CGSizeMake(295, 110);
}

@end
