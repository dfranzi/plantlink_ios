//
//  PLPlantSetupViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@class PLPlantSetupOption;
@interface PLPlantSetupViewController : PLAbstractViewController {
    IBOutlet PLPlantSetupOption *optionOne;
    IBOutlet PLPlantSetupOption *optionTwo;
    IBOutlet PLPlantSetupOption *optionThree;
}

@end
