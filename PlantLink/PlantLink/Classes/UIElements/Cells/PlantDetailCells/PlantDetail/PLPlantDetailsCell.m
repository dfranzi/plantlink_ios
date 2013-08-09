//
//  PLPlantDetailsCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantDetailsCell.h"

#import "PLPlantModel.h"
#import "PLPlantEditTextField.h"

@implementation PLPlantDetailsCell

#pragma mark -
#pragma mark Display Methods

-(void)showEdit {
    [super showEdit];
    [plantTypeTextField setEditMode:YES];
    [soilTypeTextField setEditMode:YES];
    [locationTextField setEditMode:YES];
}

-(void)hideEdit {
    [super hideEdit];
    [plantTypeTextField setEditMode:NO];
    [soilTypeTextField setEditMode:NO];
    [locationTextField setEditMode:NO];
}

#pragma mark -
#pragma mark Setters

-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    if([self model]) {
        [plantTypeTextField setText:[[self model] plantTypeKey]];
        [soilTypeTextField setText:[[self model] soilTypeKey]];
        [locationTextField setText:[[self model] environment]];
    }
}

#pragma mark -
#pragma mark Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 161+[super heightForContent:content];
}


@end
