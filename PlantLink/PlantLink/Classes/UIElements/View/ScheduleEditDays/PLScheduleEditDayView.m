//
//  PLScheduleEditDayView.m
//  PlantLink
//
//  Created by Sujay Khandekar on 10/10/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleEditDayView.h"

@implementation PLScheduleEditDayView
@synthesize day;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        day = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 102, 32)];
        [day setTextColor:[UIColor whiteColor]];
        day.text = @"";
        day.font = [UIFont systemFontOfSize:14];
        [self addSubview:day];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
