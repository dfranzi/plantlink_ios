//
//  PLScheduleView.h
//  PlantLink
//
//  Created by Robert Maciej Pieta on 1/25/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PLScheduleViewDelegate <NSObject>
-(void)daySelected:(int)day;
@end

@interface PLScheduleView : UIView
@property(nonatomic,assign) id <PLScheduleViewDelegate> delegate;
@property(nonatomic,strong) NSArray *plants;

@end
