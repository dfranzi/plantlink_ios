//
//  PLBaseStationRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLBaseStationRequest : AbstractRequest
@property(nonatomic, strong, readonly) NSString *serial;

-(id)initGetBaseStationRequest;
-(id)initAddBaseStationRequestWithSerialNumber:(NSString*)serial;
-(id)initRemoveBaseStationRequestWithSerialNumber:(NSString*)serial;

@end
