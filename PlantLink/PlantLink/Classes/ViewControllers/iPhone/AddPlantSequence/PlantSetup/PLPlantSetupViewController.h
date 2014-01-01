//
//  PLPlantSetupViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLPlantModel;
@interface PLPlantSetupViewController : PLAbstractViewController <UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate> {
    IBOutlet UITextField *inputTextField;
    IBOutlet UILabel *stepLabel;
    IBOutlet UILabel *titleLabel;
}
@property(nonatomic, strong) NSString *initialState;
@property(nonatomic, assign) BOOL updateMode;
@property(nonatomic, assign) BOOL skipToSync;
@property(nonatomic, strong) PLPlantModel *plantToUpdate;

#pragma mark -
#pragma mark Text Field Methods

-(IBAction)valueChanged:(id)sender;

@end
