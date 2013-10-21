//
//  PLScheduleEditViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 10/8/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLScheduleEditViewController.h"
#import "PLScheduleEditDayView.h"

@interface PLScheduleEditViewController() {
    
}

@end

@implementation PLScheduleEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dayArray = [[NSArray alloc] init];
    dayArray = [NSArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday",nil];
    
    for (int i = 0; i < [dayArray count]; i++){

        PLScheduleEditDayView *dayView = [[PLScheduleEditDayView alloc] initWithFrame:CGRectMake(79,143+i*36,162,32)];
        
        [dayView setDay:dayArray[i]];
        [self.view addSubview:dayView];
        
    }
}

-(IBAction)dismissPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
