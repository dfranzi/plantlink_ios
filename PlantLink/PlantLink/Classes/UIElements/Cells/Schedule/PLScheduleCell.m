//
//  PLScheduleCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 10/24/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleCell.h"

@implementation PLScheduleCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {

    }
    return self;
}

-(void)setDictionary:(NSDictionary*)dict {
    //assign values here, 'date' is the NSDate
    //      for date formatting, there is a general methods (found in the code libray, that takes a date and date format
    //  'name' is the name of the plant
}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(280, 40);
}

@end
