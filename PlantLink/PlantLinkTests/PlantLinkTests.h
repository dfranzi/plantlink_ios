//
//  PlantLinkTests.h
//  PlantLinkTests
//
//  Created by Zealous Amoeba on 5/28/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "AbstractRequestProtocol.h"

/*
 All model tests are in an array with dictionaries of the form
 {
    "class" : "PLBaseStationModel",         * The name of the model class to test
    "model" : {
        "serial" : "XFEG2351DSW"            * A model as returned from the server with values
    },
    "keys" : {
        "serialNumber" : "serial"           * A mapping of "property name" : "server model key" for each value
    }
 }
 
 These tests check for proper:
    * Model parsing and value assignemnt
    * Model archiving and unarchiving 
    * Model deep copying
*/

@interface PlantLinkTests : SenTestCase <AbstractRequestDelegate>

@end
