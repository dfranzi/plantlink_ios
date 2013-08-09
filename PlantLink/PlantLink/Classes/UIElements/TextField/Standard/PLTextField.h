//
//  PLTextField.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ValidationType_Empty @"ValidationType_Empty"
#define ValidationType_Email @"ValidationType_Email"

@interface PLTextField : UITextField

#pragma mark -
#pragma mark Validation Methods

-(void)showValidationError;
-(void)resetValidation;
-(BOOL)validForValidationType:(NSString*)validationType;


@end

