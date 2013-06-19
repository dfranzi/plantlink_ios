//
//  PLLinkRequest.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/19/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractRequest.h"

@interface PLLinkRequest : AbstractRequest
// The serial number of the link
@property(nonatomic, strong, readonly) NSString *serialNumber;

/*
 * Deletes a link with the serial number from the current user's account
 */
-(id)initDeleteLinkRequest:(NSString*)serial;

/*
 * Retrieves a link based on the serial number from the current user
 */
-(id)initGetLinkRequest:(NSString*)serial;

/*
 * Lists all links associatied with the currently logged in user
 */
-(id)initListLinksRequest;

/*
 * Registers the link's serial and ties it to the user's account
 */
-(id)initRegisterLinkRequest:(NSString*)serial;

@end
