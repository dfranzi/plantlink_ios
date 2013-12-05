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

@implementation PLSettingsBugReportCell

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)submitPushed:(id)sender {
    NSString *message = @"";
    
    if([message isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The message cannot be empty" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    bugReportRequest = [[PLUserRequest alloc] init];
    [bugReportRequest submitBugReportWithMessage:@"" andResponse:^(NSData *data, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"TThank you for your report!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }];
}

-(IBAction)closePushed:(id)sender {
    [[self parentViewController] closeSection:State_BugReport];
}

#pragma mark -
#pragma mark Override Methods

-(void)setStateDict:(NSDictionary *)stateDict {
    [super setStateDict:stateDict];
    NSLog(@"Set dict: %@",stateDict);
    
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

+(CGSize)sizeForContent:(NSDictionary*)content {
    if([content.allKeys containsObject:State_BugReport]) return CGSizeMake(295.0, 364.0);
    return CGSizeMake(295, 110);
}

@end
