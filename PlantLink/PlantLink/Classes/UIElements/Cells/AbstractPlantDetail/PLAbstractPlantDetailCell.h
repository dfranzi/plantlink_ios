//
//  PLAbstractPlantDetailCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractTBCell.h"

#define PlantInfo_EditMode @"PlantInfo-EditMode"
#define PlantInfo_InfoMode @"PlantInfo-InfoMode"
#define PlantInfo_InfoText @"PlantInfo-InfoText"

@class PLPlantModel;
@interface PLAbstractPlantDetailCell : AbstractTBCell {
    IBOutlet UILabel *titleLabel;
    IBOutlet UIView *infoContainerView;
    
    @protected
    UIView *bottomBorder;
}
@property(nonatomic, strong) NSString *infoText;
@property(nonatomic, strong) PLPlantModel *model;

#pragma mark -
#pragma mark Display Methods

-(void)showInfo;
-(void)hideInfo;
-(void)showEdit;
-(void)hideEdit;

@end
