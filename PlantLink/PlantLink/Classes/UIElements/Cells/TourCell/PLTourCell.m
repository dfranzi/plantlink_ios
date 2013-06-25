//
//  PLTourCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLTourCell.h"

#import <QuartzCore/QuartzCore.h>

@implementation PLTourCell

-(void)drawRect:(CGRect)rect {
    [contentsView.layer setCornerRadius:5.0];
    [contentsView.layer setMasksToBounds:YES];
    
    
}

#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary *)content {
    return CGSizeMake(267.0, 362.0);
}

#pragma mark -
#pragma mark Page Control Methods

-(void)setPage:(int)page ofTotal:(int)total {
    [cellPageControl setNumberOfPages:total];
    [cellPageControl setCurrentPage:page];
}

@end
