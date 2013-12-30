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

/**
 * Intializes the views parameters and creates the location manager
 */
-(void)viewDidLoad {
    [super viewDidLoad];
    [self setNextSegueIdentifier:Segue_ToAddFirstPlant];
    
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

/**
 * Cancels the registration request if active and stops updating location
 */
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [locationManager stopUpdatingLocation];
    if(registerRequest) [registerRequest cancel];
}

/**
 * Hides the navigation bar
 */
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark IBAction Methods

/**
 * Called when the search action is made, stops updating location and attempts to geocode the input address
 */
-(IBAction)searchPushed:(id)sender {
    [locationManager stopUpdatingLocation];
    NSString *address = [locationTextField text];
    [self geocode:address];
}

/**
 * Called when the user current location button is pushed, starts updating location to find the user
 */
-(IBAction)useCurrentLocationPushed:(id)sender {
    previousLocation = NULL;
    [locationManager startUpdatingLocation];
}

#pragma mark -
#pragma mark Location Methods

/**
 * Called when the location manager recieves notification updates, and updates the map and previous location pointer
 */
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

/**
 * Moves the text field up when editting so its not covered by the keyboard
 */
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    [locationManager stopUpdatingLocation];
    [UIView animateWithDuration:0.3 animations:^{
        [locationTextField setCenter:CGPointMake(160, 235)];
    }];
}

/**
 * Resets the text fields location when the keyboard dismisses
 */
-(void)textFieldDidEndEditing:(UITextField *)textField {
    [UIView animateWithDuration:0.3 animations:^{
        [locationTextField setCenter:CGPointMake(160, 302)];
    }];
}

/**
 * When the return key is pressed dismisses the keyboard and attempts to find the location
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    [self searchPushed:nil];
    return YES;
}

#pragma mark -
#pragma mark Touch Methods

/**
 * Dismisses the keyboard is the a touch is detected outside the text field
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -
#pragma mark Map Methods

/**
 * Updates the map to the given coordinates with a set coordinate span
 */
-(void)updateMapToCoordinate:(CLLocationCoordinate2D)coordiante {
     [locationMapView setRegion:MKCoordinateRegionMake(coordiante, MKCoordinateSpanMake(0.007, 0.007)) animated:YES];
}

/**
 * Attempts to geocode the given text, updating the map if successful or showing the appropriate error
 */
-(void)geocode:(NSString*)text {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:text completionHandler:^(NSArray* placemarks, NSError* error){
        if([placemarks count] > 0) {
            CLPlacemark *mark = placemarks[0];
            [self updateMapToCoordinate:mark.location.coordinate];
            if(mark.postalCode) [[sharedUser setupDict] setObject:mark.postalCode forKey:Constant_SetupDict_ZipCode];
            else [self displayErrorAlertWithMessage:Error_Registration_LocationNotFound];
        }
        else [self displayErrorAlertWithMessage:Error_Registration_ZipCodeNotFound];
    }];
}

/**
 * Attempts to get the zip code from the current location, displaying an error if not found
 */
-(void)getZip:(CLLocation*)location {
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if ([placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *zip = [placemark postalCode];
            
            if(zip) {
                [locationTextField setText:[NSString stringWithFormat:@"%@, %@",placemark.thoroughfare,placemark.locality]];
                [[sharedUser setupDict] setObject:zip forKey:Constant_SetupDict_ZipCode];
            }
            else [self displayErrorAlertWithMessage:Error_Registration_ZipCodeNotFound];
        }
    }];
    
}

#pragma mark -
#pragma mark Request Methods

/**
 * Called when the app should attempt to complete user registration and move to the next view
 */
-(void)nextPushed:(id)sender {
    if(registerRequest) return;
    
    NSDictionary *dict = [sharedUser setupDict];
    NSString *name = dict[Constant_SetupDict_Name];
    NSString *email = dict[Constant_SetupDict_Email];
    NSString *password = dict[Constant_SetupDict_Password];
    NSString *serial = dict[Constant_SetupDict_SerialNumber];
    NSString *zip = dict[Constant_SetupDict_ZipCode];
    
    if([zip isEqualToString:@""]) {
        [self displayErrorAlertWithMessage:Error_Registration_NoLocation];
        return;
    }
    
    registerRequest = [[PLUserRequest alloc] init];
    [registerRequest registerUserWithEmail:email name:name password:password zipCode:zip andBaseStationSerial:serial withResponse:^(NSData *data, NSError *error) {
        
        registerRequest = NULL;
        if(![self checkForRegistrationErrors:data]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:email forKey:Defaults_SavedEmail];
            [self loginWithEmail:email andPassword:password];
        }
        
    }];
}

/**
 * Checks for errors in the response from a request and displays an error if necessary
 */
-(BOOL)checkForRegistrationErrors:(NSData*)responseData {
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:nil];
    if([response isKindOfClass:[NSArray class]]) {
        if([self errorInRequestResponse:((NSArray*)response)[0]]) return YES;
    }
    return NO;
}

/**
 * Logs in the user with the registration parameters after successful registration
 */
-(void)loginWithEmail:(NSString*)email andPassword:(NSString*)password {
    [registerRequest loginUserWithEmail:email andPassword:password withResponse:^(NSData *data, NSError *error) {
        registerRequest = NULL;
        if(![self checkForRegistrationErrors:data]) {
            [sharedUser setLastUsername:email andPassword:password];
            [super nextPushed:nil];
        }
    }];
}

@end
