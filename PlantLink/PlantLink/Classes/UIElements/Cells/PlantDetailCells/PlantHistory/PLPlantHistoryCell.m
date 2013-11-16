//
//  PLPlantHistoryCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLPlantHistoryCell.h"

#import <QuartzCore/QuartzCore.h>
#import "PLWaterHistoryGraph.h"

@interface PLPlantHistoryCell() {
@private
}
@end

@implementation PLPlantHistoryCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [waterHistory setBackgroundColor:[UIColor redColor]];
        [self addSubview:waterHistory];
        

    }
    return self;
}

-(void)setModel:(PLPlantModel *)model {
    [super setModel:model];
    [waterHistory setPlant:model];
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    return 336+[super heightForContent:content];
}

@end
