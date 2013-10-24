//
//  PLScheduleEditDayView.m
//  PlantLink
//
//  Created by Sujay Khandekar on 10/10/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleEditDayView.h"

@implementation PLScheduleEditDayView

-(id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createLayout];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self createLayout];
    }
    return self;
}

-(void)createLayout {
    self.backgroundColor = [UIColor blackColor];
//    day = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 102, 32)];
//    [day setTextColor:[UIColor whiteColor]];
//    day.text = @"";
//    day.font = [UIFont systemFontOfSize:14];
//    [self addSubview:day];
    
    //create labels, buttons, set defaults, blah lbah lba
}

#pragma mark -
#pragma mark Override Methods

-(void)setDay:(NSString *)day {
    _day = day;
    [dayLabel setText:_day];
}

#pragma mark -
#pragma mark Action Methods

-(void)switchPushed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        [checkButton setFrame:CGRectMake(checkButton.frame.origin.x, checkButton.frame.origin.y, 0, checkButton.frame.size.height)];
    } completion:^(BOOL finished) {
        //change the image
        [UIView animateWithDuration:0.3 animations:^{
            [checkButton setFrame:CGRectMake(checkButton.frame.origin.x, checkButton.frame.origin.y, 0, checkButton.frame.size.width)];
        }];
    }];
}


@end
