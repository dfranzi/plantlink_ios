//
//  PLSerialInputViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLTextField;
@interface PLSerialInputViewController : PLAbstractViewController <UITextFieldDelegate> {
    IBOutlet PLTextField *serialTextField;
}

@end
