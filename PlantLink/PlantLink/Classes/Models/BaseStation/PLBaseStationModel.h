//
//  PLBaseStationModel.h
//  PlantLink
//
//  Created by Zealous Amoeba on 5/29/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractModel.h"

@interface PLBaseStationModel : AbstractModel
@property(nonatomic, strong, readonly) NSString *serialNumber;

@end
