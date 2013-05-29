//
//  PLUserModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLUserModel : AbstractModel
@property(nonatomic, strong, readonly) NSString *email;
@property(nonatomic, strong, readonly) NSString *phone;
@property(nonatomic, strong, readonly) NSString *name;
@property(nonatomic, strong, readonly) NSString *zip;

@property(nonatomic, assign, readonly) BOOL emailAlerts;
@property(nonatomic, assign, readonly) BOOL textAlerts;
@property(nonatomic, assign, readonly) BOOL pushAlerts;

@end
