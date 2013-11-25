//
//  PLSettingsCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLSettingsCell : UICollectionViewCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *infoLabel;
}

#pragma mark -
#pragma mark Display Methods

-(void)setTitle:(NSString*)title;
-(void)setLabel:(NSString*)label;

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content;

@end
