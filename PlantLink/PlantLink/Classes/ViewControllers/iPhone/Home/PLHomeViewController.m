//
//  PLHomeViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/9/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLHomeViewController.h"

#import "PLUserManager.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>

@interface PLHomeViewController() {
@private
    NSDate *startDate;
}
@end

@implementation PLHomeViewController

#warning Temp for demo
-(void)viewDidLoad {
    [super viewDidLoad];
    //UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    //[self.view addGestureRecognizer:recognizer];
//    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.000) {
//        UIImage *image = [GeneralMethods imageWithColor:Color_NavBar_Background andSize:CGSizeMake(320,20)];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        
//        [[[[UIApplication sharedApplication] delegate] window] addSubview:imageView];
//        [self.navigationController setNavigationBarHidden:YES animated:NO];
//    }
}

-(void)longPress:(id)sender {
//    UILongPressGestureRecognizer *recognizer = (UILongPressGestureRecognizer*)sender;
//    if(recognizer.state == UIGestureRecognizerStateEnded) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Scheduled Notification" message:@"" delegate:self cancelButtonTitle:@"Done" otherButtonTitles:@"1 - overwatered",@"2 - underwatered",@"3 - notified",@"4 - watered",nil];
//        [alert show];
//    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    ZALog(@"Button index: %i",buttonIndex);
    if(buttonIndex == [alertView cancelButtonIndex]) return;
    
    NSString *message = @"One of your plants need to be watered.";
    if(buttonIndex == 1) message = @"One of your plants has been overwatered.";
    else if(buttonIndex == 2) message = @"One of your plants is underwatered.";
    else if(buttonIndex == 3) message = @"Robert has been notified to water your plant.";
    
    UILocalNotification* n1 = [[UILocalNotification alloc] init];
    n1.fireDate = [NSDate dateWithTimeIntervalSinceNow:15];
    n1.alertBody = message;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:n1];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [sharedUser setPlantReloadTrigger:YES];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)setupPushed:(id)sender {
    [sharedUser setLoginType:Constant_LoginType_Setup];
    [self performSegueWithIdentifier:Segue_ToLogin sender:self];
}

-(IBAction)loginPushed:(id)sender {
    [sharedUser setLoginType:Constant_LoginType_Login];
    [self performSegueWithIdentifier:Segue_ToLogin sender:self];
}

@end
