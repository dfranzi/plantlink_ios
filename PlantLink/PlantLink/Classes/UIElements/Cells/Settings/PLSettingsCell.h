//
//  PLSettingsCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractTBCell.h"

@interface PLSettingsCell : AbstractTBCell {
    IBOutlet UILabel *titleLabel;
}

#pragma mark -
#pragma mark Display Methods

-(void)setTitle:(NSString*)title;

@end
