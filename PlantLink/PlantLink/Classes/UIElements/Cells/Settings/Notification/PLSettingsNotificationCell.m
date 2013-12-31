//
//  PLSettingsNotificationCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 11/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsNotificationCell.h"
#import "PLSettingsViewController.h"

@interface PLSettingsNotificationCell() {
@private
    BOOL morningNotifications;
    BOOL middayNotifications;
    BOOL afternoonNotifications;
    BOOL eveningNotifications;
}

@end

@implementation PLSettingsNotificationCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        morningNotifications = NO;
        middayNotifications = NO;
        afternoonNotifications = NO;
        eveningNotifications = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Override Methods

-(void)setHighlighted:(BOOL)highlighted {
    if(![[self stateDict].allKeys containsObject:State_Notifications]) [super setHighlighted:highlighted];
}

-(void)setStateDict:(NSDictionary *)stateDict {
    [super setStateDict:stateDict];

    if([stateDict.allKeys containsObject:State_Notifications]) {
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

-(IBAction)morningPushed:(id)sender {
    morningNotifications = !morningNotifications;
    [self changeButton:morningButton withBooleanFlag:morningNotifications];
}

-(IBAction)middayPushed:(id)sender {
    middayNotifications = !middayNotifications;
    [self changeButton:middayButton withBooleanFlag:middayNotifications];
}

-(IBAction)afternoonPushed:(id)sender {
    afternoonNotifications = !afternoonNotifications;
    [self changeButton:afternoonButton withBooleanFlag:afternoonNotifications];
}

-(IBAction)eveningPushed:(id)sender {
    eveningNotifications = !eveningNotifications;
    [self changeButton:eveningButton withBooleanFlag:eveningNotifications];
}

-(IBAction)closePushed:(id)sender {
    [[self parentViewController] closeSection:State_Notifications];
}

-(IBAction)morePushed:(id)sender {
    
}

#pragma mark -
#pragma mark Display Methods

-(void)changeButton:(UIButton*)button withBooleanFlag:(BOOL)flag {
    NSString *imageName = @"checkmarkGray.png";
    if(flag) imageName = @"checkmarkBlue.png";
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    if([content.allKeys containsObject:State_Notifications]) return CGSizeMake(295, 270);
    return CGSizeMake(295, 110);
}

@end
