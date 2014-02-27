//
//  PLSerialInputViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSerialInputViewController.h"

#import "PLTextField.h"
#import "PLUserManager.h"
#import "PLItemRequest.h"
#import <MediaPlayer/MediaPlayer.h>

@interface PLSerialInputViewController() {
@private
    PLItemRequest *stationRequest;
    MPMoviePlayerController *moviePlayer;
}

@end

@implementation PLSerialInputViewController

/**
 * Loads the initial parameters for the view and the subivews
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToAddFirstPlant];
    [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(popView:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    [self.navigationItem setTitle:@"Serial Number"];
    [serialTextField setTitle:@"Serial #"];
    serialTextField.placeholder = @"####-####-####";
    
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://oso.blob.core.windows.net/content/Basestation%20Setup.mp4"];
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
    moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    moviePlayer.shouldAutoplay = YES;
    moviePlayer.view.alpha = 1.0f;
    [self.view insertSubview:moviePlayer.view belowSubview:serialTextField];
}

/*
 * Setups up the movie player parameters to player when the view appears
 */
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [moviePlayer setFullscreen:NO animated:NO];
    moviePlayer.view.frame = CGRectMake(0, 64, 320, 160);
}

#pragma mark -
#pragma mark Text Field Methods

/**
 * Dismisses the keyboard upon clicking return and attempts to move to the next view
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self nextPushed:nil];
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

/**
 * Dismisses the keyboard if the view is touched outside of the text field
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Next Methods

/**
 * Transitions to the next view if the serial is non-empty, otherwise shows an error alert
 */
-(void)nextPushed:(id)sender {
    if(stationRequest) return;
    
    NSString *serial = serialTextField.text;
    serial = [serial stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if([serial isEqualToString:@""]) {
        [self displayErrorAlertWithMessage:Error_Registration_NoSerial];
        return;
    }
    else if([serial length] != 12) {
        [self displayErrorAlertWithMessage:Error_Registration_IncorrectSerial];
        return;
    }
    
    stationRequest = [[PLItemRequest alloc] init];
    __block PLItemRequest *request = stationRequest;
    __block PLSerialInputViewController *controller = self;
    __block PLUserManager *userManager = sharedUser;
    __block PLItemRequest *itemRequest = stationRequest;
    
    [stationRequest addBaseStation:serial withResponse:^(NSData *data, NSError *error) {
        if(error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"uh oh" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alert show];
            request = NULL;
            return;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if([dict isKindOfClass:[NSArray class]]) {
            if([controller errorInRequestResponse:((NSArray*)dict)[0]]) {
                request = NULL;
                return;
            }
        }
        
        [userManager refreshUserData];
        itemRequest = NULL;
        [super nextPushed:sender];
        
    }];
}

@end
