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
        
<<<<<<< HEAD
        
        //dayView.day.text = dayArray[i];
        //Button Implementation. No Buttons Available. Redo when images are available
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //[button addTarget:self action:@selector() forControlEvents:UIControlEventTouchDown];
        [button setImage:[UIImage imageNamed:@"xicon.png"] forState:UIControlStateNormal];
        button.frame = CGRectMake(182, 146+i*36, 25, 25);
        [self.view addSubview:button];
        
=======
>>>>>>> 05981b9cec62d1035a161d9dc5b05a11e969d040
    }
}

-(IBAction)dismissPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
