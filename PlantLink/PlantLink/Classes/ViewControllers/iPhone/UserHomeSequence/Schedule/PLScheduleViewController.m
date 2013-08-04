//
//  PLCalendarViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleViewController.h"

@interface PLScheduleViewController() {
@private
}

@end

@implementation PLScheduleViewController

-(void)viewDidLoad {
    ZALog(@"Schedule");
    [super viewDidLoad];
    
    UIImage *schedule = [UIImage imageNamed:Image_Tab_Schedule];
    UIImage *scheduleHighlighted = [UIImage imageNamed:Image_Tab_ScheduleHighlighted];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:scheduleHighlighted withFinishedUnselectedImage:schedule];
}

@end
