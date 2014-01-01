//
//  PLAbstractPlantDetailCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PlantInfo_EditMode @"PlantInfo-EditMode"
#define PlantInfo_InfoMode @"PlantInfo-InfoMode"
#define PlantInfo_InfoText @"PlantInfo-InfoText"

@class PLPlantModel;
@class PLPlantDetailViewController;
@interface PLAbstractPlantDetailCell : UITableViewCell {
    UIView *bottomBorder;
}
@property(nonatomic, weak) PLPlantDetailViewController *enclosingController;
@property(nonatomic, strong) PLPlantModel *model;
@property(nonatomic, assign) BOOL editMode;

#pragma mark -
#pragma mark Display Methods

-(void)updateBorder;

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content;

@end
