//
//  PLHomeViewController.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"

@interface PLHomeViewController : PLAbstractViewController {
    IBOutlet UIImageView *logoImage;
    IBOutlet UILabel *sloganLabel;
    
    IBOutlet UIButton *loginButton;
    IBOutlet UIButton *registerButton;
    IBOutlet UIButton *learnMoreButton;
}

#pragma mark -
#pragma mark IBAction Methods

-(IBAction)loginPushed:(id)sender;
-(IBAction)registerPushed:(id)sender;
-(IBAction)learnMorePushed:(id)sender;

@end
