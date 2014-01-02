//
//  PLMoistureIndicator.h
//  PlantLink
//
//  Created by Zealous Amoeba on 8/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLMoistureIndicator : UIView
@property(nonatomic, assign, readonly) BOOL onLowestMoisture;
@property(nonatomic, strong) NSString *status;

@end
