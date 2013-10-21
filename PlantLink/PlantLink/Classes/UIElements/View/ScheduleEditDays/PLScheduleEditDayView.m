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
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 131, 32)];
    [dayLabel setBackgroundColor:[UIColor blackColor]];
    [dayLabel setTextColor:[UIColor whiteColor]];
    dayLabel.text = @"";
    dayLabel.font = [UIFont systemFontOfSize:17];
    [dayLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:dayLabel];
    
    checkButton = [[UIButton alloc] initWithFrame:CGRectMake(131, 2, 30, 28)];
    [checkButton setImage:[UIImage imageNamed:@"xwhite"] forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(switchPushed:) forControlEvents:UIControlEventTouchUpInside];
    [checkButton setBackgroundColor:Color_Alizarin];
    [self addSubview:checkButton];
    
    pushed = false;
   
}

#pragma mark -
#pragma mark Override Methods

-(void)setDay:(NSString *)day {
    _day = day;
    [dayLabel setText:_day];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if([defaults objectForKey:_day]) pushed = [[defaults objectForKey:_day] boolValue];
    else [defaults setObject:[NSNumber numberWithBool:pushed] forKey:_day];
    
    [self updateLayout];
}

#pragma mark -
#pragma mark Action Methods

-(void)updateLayout {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:pushed] forKey:_day];
    
    if (pushed){
        [checkButton setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
        [checkButton setBackgroundColor:Color_Emerland];
    }else{
        [checkButton setImage:[UIImage imageNamed:@"xwhite.png"] forState:UIControlStateNormal];
        [checkButton setBackgroundColor:Color_Alizarin];
    }
}

-(void)switchPushed:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        [checkButton setFrame:CGRectMake(checkButton.frame.origin.x, checkButton.frame.origin.y, 0, checkButton.frame.size.height)];
    } completion:^(BOOL finished) {
        //change the image
        pushed = !pushed;
        [self updateLayout];
        [UIView animateWithDuration:0.3 animations:^{
            [checkButton setFrame:CGRectMake(checkButton.frame.origin.x, checkButton.frame.origin.y, checkButton.frame.size.height+2, checkButton.frame.size.height)];
        }];
    }];
}


@end
