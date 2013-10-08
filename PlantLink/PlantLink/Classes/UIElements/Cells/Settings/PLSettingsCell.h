//
//  PLSettingsCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLSettingsCell : UITableViewCell {
    IBOutlet UILabel *titleLabel;
}

#pragma mark -
#pragma mark Display Methods

-(void)setTitle:(NSString*)title;

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content;

@end
