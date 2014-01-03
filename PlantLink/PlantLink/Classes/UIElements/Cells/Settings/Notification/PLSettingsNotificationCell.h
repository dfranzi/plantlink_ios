//
//  PLSettingsNotificationCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 11/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsCell.h"
#import "PLSmsView.h"

@class PLMenuButton;
@interface PLSettingsNotificationCell : PLSettingsCell <UIAlertViewDelegate,SmsViewDelegate> {
    IBOutlet UIButton *morningButton;
    IBOutlet UIButton *middayButton;
    IBOutlet UIButton *afternoonButton;
    IBOutlet UIButton *eveningButton;

    IBOutlet UIButton *emailButton;
    IBOutlet UIButton *pushButton;
    IBOutlet UIButton *smsButton;
    
    IBOutlet PLMenuButton *closeButton;
    IBOutlet PLMenuButton *moreButton;
}

#pragma mark -
#pragma mark Action Methods

-(IBAction)morningPushed:(id)sender;
-(IBAction)middayPushed:(id)sender;
-(IBAction)afternoonPushed:(id)sender;
-(IBAction)eveningPushed:(id)sender;

-(IBAction)emailPushed:(id)sender;
-(IBAction)pushPushed:(id)sender;
-(IBAction)smsPushed:(id)sender;

-(IBAction)closePushed:(id)sender;
-(IBAction)morePushed:(id)sender;

@end
