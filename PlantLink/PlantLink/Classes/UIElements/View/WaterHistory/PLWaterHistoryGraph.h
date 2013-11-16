//
//  PLWaterHistoryGraph.h
//  PlantLink
//
//  Created by Zealous Amoeba on 11/7/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLPlantModel;
@interface PLWaterHistoryGraph : UIView {
    IBOutlet UILabel *tooWet;
    IBOutlet UILabel *tooDry;
    
    NSArray *moistureHistory;
}

@property(nonatomic,strong) PLPlantModel *plant;

@end
