//
//  PLSettingsContactCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 11/30/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsCell.h"

@interface PLSettingsBugReportCell : PLSettingsCell <UITextViewDelegate> {
    IBOutlet UITextView *messageTextView;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)submitPushed:(id)sender;
-(IBAction)closePushed:(id)sender;

@end
