//
//  PLLocationInputViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLocationInputViewController.h"

#import "PLTextField.h"

@interface PLLocationInputViewController() {
@private
}

@end

@implementation PLLocationInputViewController

#warning Option should exist to get current user location

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToInformation];
    
    [self addLeftNavButtonWithImageNamed:Image_Navigation_BackButton toNavigationItem:self.navigationItem withSelector:@selector(popView:)];
    [self addRightNavButtonWithImageNamed:Image_Navigation_NextButton toNavigationItem:self.navigationItem withSelector:@selector(nextPushed:)];
    
    [locationTextField setBackgroundColor:SHADE(250.0)];
    
    [self.navigationItem setTitle:@"Location"];
    [locationTextField setTitle:@"Location"];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)searchPushed:(id)sender {
    NSString *address = [locationTextField text];
    [self geocode:address];
}

-(IBAction)useCurrentLocationPushed:(id)sender {

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
