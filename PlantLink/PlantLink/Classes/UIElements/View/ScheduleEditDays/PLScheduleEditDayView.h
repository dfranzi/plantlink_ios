//
//  PLScheduleEditDayView.h
//  PlantLink
//
//  Created by Sujay Khandekar on 10/10/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLScheduleEditDayView : UIView {
    @protected
    UILabel *dayLabel;
    UIButton *checkButton;
    BOOL pushed;
    
}
@property(nonatomic, strong) NSString *day;

@end
