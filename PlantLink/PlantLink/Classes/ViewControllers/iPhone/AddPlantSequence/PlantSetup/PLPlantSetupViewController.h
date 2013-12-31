//
//  PLPlantSetupViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLPlantSetupViewController : PLAbstractViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITextField *inputTextField;
    IBOutlet UILabel *stepLabel;
    IBOutlet UILabel *titleLabel;
}

#pragma mark -
#pragma mark Text Field Methods

-(IBAction)valueChanged:(id)sender;

@end
