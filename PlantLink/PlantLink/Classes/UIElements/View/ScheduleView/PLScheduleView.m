//
//  PLScheduleView.m
//  PlantLink
//
//  Created by Robert Maciej Pieta on 1/25/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleView.h"
#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"

@interface PLScheduleView() {
@private
    NSMutableArray *items;
    NSMutableArray *dates;
}

@end

@implementation PLScheduleView

-(id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setBackgroundColor:Color_PlantLinkBackground];
        items = [NSMutableArray array];
        dates = [NSMutableArray array];
        
        [self addItemBoxes];
        [self addLabels];
        [self setPlants:@[]];
    }
    return self;
}

#pragma mark -
#pragma mark Layout Methods

-(void)addLabels {
    int index = 0;
    for(NSString *day in @[@"Sun",@"Mon",@"Tue",@"Wed",@"Thur",@"Fri",@"Sat"]) {
        UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(14+index*42, 35, 40, 20)];
        [dayLabel setBackgroundColor:Color_PlantLinkBackground];
        [dayLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
        [dayLabel setTextAlignment:NSTextAlignmentCenter];
        [dayLabel setText:day];
        [self addSubview:dayLabel];
        
        index++;
    }
}

-(void)addItemBoxes {
    for(UIView *item in items) [item removeFromSuperview];
    [items removeAllObjects];
    
    for(int i = 0; i < 2; i++) {
        for(int j = 0; j < 7; j++) {
            UIButton *item = [[UIButton alloc] initWithFrame:CGRectMake(14+j*42, 56+i*42, 40, 40)];
            [item setBackgroundColor:Color_PlantLinkSubtitle];
            [[item titleLabel] setTextAlignment:NSTextAlignmentCenter];
            [[item titleLabel] setFont:[UIFont fontWithName:@"HelveticaNeue" size:14.0]];
            [item setTitleColor:Color_PlantLinkTitle forState:UIControlStateNormal];
            [item.layer setCornerRadius:2.0];
            [item setClipsToBounds:YES];
            [item addTarget:self action:@selector(itemPushed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:item];
            
            [items addObject:item];
        }
    }
}

#pragma mark -
#pragma mark Model Methods

-(void)setPlants:(NSArray *)plants {
    _plants = plants;
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *component = [calender components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    
    int day = [component weekday];
    UIButton *todayButton = items[day-1];
    
    [dates removeAllObjects];
    for(int i = 0; i < 14; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60*60*24*(i-day+1)];
        [dates addObject:date];
        UIButton *itemButton = items[i];
        
        NSDateComponents *itemComponent = [calender components:NSDayCalendarUnit fromDate:date];
        [itemButton setTitle:[NSString stringWithFormat:@"%i",[itemComponent day]] forState:UIControlStateNormal];
        [itemButton setBackgroundImage:[GeneralMethods imageWithColor:Color_PlantLinkSubtitle andSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
        [itemButton setTitleColor:Color_PlantLinkTitle forState:UIControlStateNormal];
        [itemButton setTag:[itemComponent day]];
        
        for(PLPlantModel *plant in plants) {
            NSDate *plantDate = [[plant lastMeasurement] predictedWaterDate];

            if(plantDate) {
                NSDateComponents *plantComponent = [calender components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit fromDate:plantDate];
                
                if([plantComponent day] == [itemComponent day]) {
                    [itemButton setBackgroundImage:[GeneralMethods imageWithColor:Color_PlantLinkBlue andSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
                    
                    [itemButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                }
            }
        }
    }

    [todayButton setBackgroundImage:[GeneralMethods imageWithColor:Color_PlantLinkRed andSize:CGSizeMake(1, 1)] forState:UIControlStateNormal];
    
    [todayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark Action Methods

-(void)itemPushed:(id)sender {
    UIButton *button = (UIButton*)sender;
    if([[button backgroundColor] isEqual:Color_PlantLinkBlue] || [[button backgroundColor] isEqual:Color_PlantLinkRed]) {
        [[self delegate] daySelected:button.tag];
    }
}

@end
