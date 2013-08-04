//
//  PLNotificationsViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/17/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLNotificationsViewController.h"

@interface PLNotificationsViewController() {
@private
}

@end

@implementation PLNotificationsViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *clock = [UIImage imageNamed:Image_Tab_Clock];
    UIImage *clockHighlighted = [UIImage imageNamed:Image_Tab_ClockHighlighted];
    
    [self.tabBarItem setTitle:@""];
    [self.tabBarItem setFinishedSelectedImage:clockHighlighted withFinishedUnselectedImage:clock];
}


@end
