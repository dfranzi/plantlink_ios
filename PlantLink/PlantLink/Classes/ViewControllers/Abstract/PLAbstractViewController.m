//
//  PLAbstractViewController.m
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractViewController.h"
#import "PLUserManager.h"

@interface PLAbstractViewController() {
@private

}
@end

@implementation PLAbstractViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    sharedUser = [PLUserManager initializeUserManager];
}

@end
