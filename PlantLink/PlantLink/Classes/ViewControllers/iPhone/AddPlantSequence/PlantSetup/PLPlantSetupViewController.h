//
//  PLPlantSetupViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLPlantSetupOption;
@interface PLPlantSetupViewController : PLAbstractViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet PLPlantSetupOption *optionOne;
    IBOutlet PLPlantSetupOption *optionTwo;
    IBOutlet PLPlantSetupOption *optionThree;
}

#pragma mark -
#pragma mark Text Field Methods

-(IBAction)valueChanged:(id)sender;

@end
