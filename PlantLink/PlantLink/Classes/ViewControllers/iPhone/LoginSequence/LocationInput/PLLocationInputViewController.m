//
//  PLLocationInputViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLLocationInputViewController.h"

#import "PLTextField.h"
#import "PLUserManager.h"
#import "PLUserRequest.h"

@interface PLLocationInputViewController() {
@private
    CLLocationManager *locationManager;
    PLUserRequest *registerRequest;
    
    CLLocation *previousLocation;
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
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    previousLocation = NULL;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [locationManager stopUpdatingLocation];
    if(registerRequest) [registerRequest cancel];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)searchPushed:(id)sender {
    [locationManager stopUpdatingLocation];
    NSString *address = [locationTextField text];
    [self geocode:address];
}

-(IBAction)useCurrentLocationPushed:(id)sender {
    previousLocation = NULL;
    [locationManager startUpdatingLocation];
}

#pragma mark -
#pragma mark Location Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)location {
    if([location count] > 0) {
        CLLocation *loc = [location lastObject];
        if(previousLocation && fabs(previousLocation.coordinate.latitude-loc.coordinate.latitude) < 0.003) {
            MKCoordinateRegion region = MKCoordinateRegionMake(loc.coordinate, MKCoordinateSpanMake(0.007, 0.007));
            [locationMapView setRegion:region animated:YES];
            [locationManager stopUpdatingLocation];
            [self getZip:loc];
        }
        previousLocation = loc;
    }
}

#pragma mark -
#pragma mark Text Field Methods

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [locationManager stopUpdatingLocation];
    [UIView animateWithDuration:0.3 animations:^{
        [locationTextField setCenter:CGPointMake(160, 235)];
    }];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        [locationTextField setCenter:CGPointMake(160, 302)];
    }];
}

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
     [locationMapView setRegion:MKCoordinateRegionMake(coordiante, MKCoordinateSpanMake(0.007, 0.007)) animated:YES];
}

-(void)addressNotFound {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"The address could not be found." delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
}

-(void)geocode:(NSString*)text {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:text completionHandler:^(NSArray* placemarks, NSError* error){
        if([placemarks count] > 0) {
            CLPlacemark *mark = placemarks[0];
            [self updateMapToCoordinate:mark.location.coordinate];
            [[sharedUser setupDict] setObject:mark.postalCode forKey:Constant_SetupDict_ZipCode];
        }
        else [self addressNotFound];
    }];
}

-(void)getZip:(CLLocation*)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *zip = [placemark postalCode];

            [locationTextField setText:[NSString stringWithFormat:@"%@, %@",placemark.thoroughfare,placemark.locality]];
            [[sharedUser setupDict] setObject:zip forKey:Constant_SetupDict_ZipCode];
        }
    }];
    
}

#pragma mark -
#pragma mark Request Methods

-(void)nextPushed:(id)sender {
    if(registerRequest) return;
    NSDictionary *dict = [sharedUser setupDict];
    NSString *name = dict[Constant_SetupDict_Name];
    NSString *email = dict[Constant_SetupDict_Email];
    NSString *password = dict[Constant_SetupDict_Password];
    NSString *serial = dict[Constant_SetupDict_SerialNumber];
    NSString *zip = dict[Constant_SetupDict_ZipCode];
    
    if([zip isEqualToString:@""]) {
        [self displayAlert:@"Please enter a location"];
        return;
    }
    
    ZALog(@"Setup dict: %@",dict);
    
    registerRequest = [[PLUserRequest alloc] init];
    [registerRequest registerUserWithEmail:email name:name password:password zipCode:zip andBaseStationSerial:serial withResponse:^(NSData *data, NSError *error) {
        ZALog(@"data: %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *response = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        if([response isKindOfClass:[NSArray class]]) {
            if([self errorInRequestResponse:((NSArray*)response)[0]]) {
                registerRequest = NULL;
                return;
            }
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:email forKey:Defaults_SavedEmail];
        
        [registerRequest loginUserWithEmail:email andPassword:password withResponse:^(NSData *data, NSError *error) {
            
            [sharedUser setLastUsername:email andPassword:password];
            [super nextPushed:nil];
            registerRequest = NULL;
        }];
    }];
}

-(void)displayAlert:(NSString*)alert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:alert delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alertView show];
}

@end
