//
//  PLSettingsCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLSettingsViewController;
@interface PLSettingsCell : UICollectionViewCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *infoLabel;
    
    @protected
    UIView *background;
    UIView *backdrop;
    CGPoint originalCenter;
}
@property(nonatomic, strong) NSDictionary *stateDict;
@property(nonatomic, weak) PLSettingsViewController *parentViewController;

#pragma mark -
#pragma mark Display Methods

-(void)setTitle:(NSString*)title;
-(void)setLabel:(NSString*)label;

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content;

@end
