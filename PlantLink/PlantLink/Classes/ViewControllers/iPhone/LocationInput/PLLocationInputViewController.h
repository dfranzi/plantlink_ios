//
//  PLLocationInputViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 7/16/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"
#import <MapKit/MapKit.h>

@class PLTextField;
@interface PLLocationInputViewController : PLAbstractViewController <UITextFieldDelegate,MKMapViewDelegate> {
    IBOutlet PLTextField *locationTextField;
    IBOutlet MKMapView *locationMapView;
}

@end
