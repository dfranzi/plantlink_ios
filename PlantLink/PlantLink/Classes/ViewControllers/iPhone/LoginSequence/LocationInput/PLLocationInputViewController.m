//
//  PLLocationInputViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLocationInputViewController.h"

#import "PLTextField.h"
#import "LocationManager.h"

@interface PLLocationInputViewController() {
@private
    LocationManager *sharedLocation;
}

@end

@implementation PLLocationInputViewController

#warning Option should exist to get current user location

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToInformation];
    
    sharedLocation = [LocationManager initializeLocationManager];
    [locationTextField setBackgroundColor:SHADE(250.0)];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark Notification Methods

-(void)recievedNotification:(NSNotification*)notification {
    NSString *type = (NSString*)[notification object];
    if([[notification name] isEqualToString:Notification_Location_Update] && [type isEqualToString:Location_Update_Location]) {
        [self updateMapToCoordinate:[sharedLocation currentLocation].coordinate];
    }
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)searchPushed:(id)sender {
    NSString *address = [locationTextField text];
    [self geocode:address];
}

-(IBAction)getCurrentLocationPushed:(id)sender {
    [sharedLocation startLocationUpdates];
}

#pragma mark -
#pragma mark Text Field Methods

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchPushed:nil];
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Map Methods

-(void)updateMapToCoordinate:(CLLocationCoordinate2D)coordiante {
     [locationMapView setRegion:MKCoordinateRegionMake(coordiante, MKCoordinateSpanMake(0.015, 0.015)) animated:YES];
}

-(void)addressNotFound {
    #warning Error not yet implemented
}

-(void)geocode:(NSString*)text {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:text completionHandler:^(NSArray* placemarks, NSError* error){
        if([placemarks count] > 0) {
            CLPlacemark *mark = placemarks[0];
            [self updateMapToCoordinate:mark.location.coordinate];
        }
        else [self addressNotFound];
    }];
}

@end
