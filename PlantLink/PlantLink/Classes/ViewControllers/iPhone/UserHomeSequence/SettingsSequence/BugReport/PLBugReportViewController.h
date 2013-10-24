//
//  PLBugReportViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"


@class PLTextField;
@interface PLBugReportViewController : PLAbstractViewController <UITextViewDelegate> {
    IBOutlet UITextView *bugReportView;
    
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)backPushed:(id)sender;
-(IBAction)sendPushed:(id)sender;


@end
