//
//  PLPlantSetupOption.h
//  PlantLink
//
//  Created by Zealous Amoeba on 9/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLPlantSetupOption : UIView {
    IBOutlet UILabel *numberLabel;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *infoLabel;
}
@property(nonatomic, strong) IBOutlet UITextField *inputField;


@end
