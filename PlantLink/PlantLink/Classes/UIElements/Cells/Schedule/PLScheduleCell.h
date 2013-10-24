//
//  PLScheduleCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 10/24/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLScheduleCell : UICollectionViewCell

-(void)setDictionary:(NSDictionary*)dict;

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content;

@end
