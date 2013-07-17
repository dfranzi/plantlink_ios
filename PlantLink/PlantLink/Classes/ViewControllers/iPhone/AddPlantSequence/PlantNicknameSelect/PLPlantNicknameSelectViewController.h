//
//  PLPlantNicknameSelectViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLTextField;
@interface PLPlantNicknameSelectViewController : PLAbstractViewController <UITextFieldDelegate> {
    IBOutlet UILabel *plantTypeLabel;
    IBOutlet UILabel *soilTypeLabel;
    
    IBOutlet PLTextField *nicknameTextField;
}

@end
