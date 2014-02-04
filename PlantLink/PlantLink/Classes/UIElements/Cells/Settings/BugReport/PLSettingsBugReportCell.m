//
//  PLSettingsContactCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 11/30/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsBugReportCell.h"
#import "PLSettingsViewController.h"

#import "PLUserRequest.h"

@interface PLSettingsBugReportCell() {
    PLUserRequest *bugReportRequest;
}

@end

#define Alert_ErrorTitle @"Uh oh"
#define Alert_NoMessage @"Please enter a bug report."
#define Alert_SuccessTitle @"Thank You"
#define Alert_SuccessMessage @"We appreciate your feedback and support."

@implementation PLSettingsBugReportCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self.layer setShouldRasterize:NO];
        
    }
    return self;
}

#pragma mark -
#pragma mark IBAction Methods

/**
 * Called when the submit button is pushed, attempts to submit the bug report displaying an error if necessary
 */
-(IBAction)submitPushed:(id)sender {
    NSString *message = messageTextView.text;
    
    if([message isEqualToString:@""]) [self displayAlertWithTitle:Alert_ErrorTitle andMessage:Alert_NoMessage];
    else {
        bugReportRequest = [[PLUserRequest alloc] init];
        [bugReportRequest submitBugReportWithMessage:@"" andResponse:^(NSData *data, NSError *error) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if([dict isKindOfClass:[NSArray class]]) {
                if([self errorInRequestResponse:((NSArray*)dict)[0]]) {}
            }
            else {
                [self displayAlertWithTitle:Alert_SuccessTitle andMessage:Alert_SuccessMessage];
                messageTextView.text = @"";
                [self closePushed:nil];
            }
        }];
    }
}

/**
 * Called when the close button is pushed, updates the state on the parent so that the cell can close its expanded section
 */
-(IBAction)closePushed:(id)sender {
    [[self parentViewController] closeSection:State_BugReport];
}

#pragma mark -
#pragma mark Override Methods

/**
 * Prevents the push down animation from happening if the cell is expanded
 */
-(void)setHighlighted:(BOOL)highlighted {
    if(![[self stateDict].allKeys containsObject:State_BugReport]) [super setHighlighted:highlighted];
}

/**
 * When a new state is set updates the cells size, animating the change if there is one
 */
-(void)setStateDict:(NSDictionary *)stateDict {
    [super setStateDict:stateDict];
    
    if([stateDict.allKeys containsObject:State_BugReport]) {
        [UIView animateWithDuration:0.3 animations:^{
            CGSize size = [PLSettingsBugReportCell sizeForContent:stateDict];
            [background setFrame:CGRectMake(0, 0, size.width, size.height-2)];
            [backdrop setFrame:CGRectMake(0, 0, size.width, size.height+1)];
        } completion:^(BOOL finished) {}];
    }
    else {
        CGSize size = [PLSettingsBugReportCell sizeForContent:stateDict];
        [UIView animateWithDuration:0.3 animations:^{
            [background setFrame:CGRectMake(0, 0, size.width, size.height-2)];
            [backdrop setFrame:CGRectMake(0, 0, size.width, size.height+1)];
        }];
    }
    
    self.contentView.bounds = CGRectMake(self.contentView.bounds.origin.x, self.contentView.bounds.origin.y, self.frame.size.width, self.frame.size.height);
}

#pragma mark -
#pragma mark Size Methods

/**
 * Returns the size for the cell in expanded and closed states
 */
+(CGSize)sizeForContent:(NSDictionary*)content {
    if([content.allKeys containsObject:State_BugReport]) return CGSizeMake(295.0, 364.0);
    return CGSizeMake(295, 110);
}

@end
