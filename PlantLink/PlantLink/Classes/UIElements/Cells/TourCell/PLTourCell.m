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
    [greenBottomView.layer setCornerRadius:5.0];
    
    [greenBottomView.layer setShadowColor:Color_MainShadow.CGColor];
    [greenBottomView.layer setShadowOffset:CGSizeMake(0.0, 2.0)];
    [greenBottomView.layer setShadowOpacity:1.0];
    [greenBottomView.layer setShadowRadius:0.0f];
    
    [greenBottomView.layer setShouldRasterize:YES];
    [greenBottomView.layer setRasterizationScale:[UIScreen mainScreen].scale];
    
    [self setContent];
}

#pragma mark -
#pragma mark Content Methods

-(void)setContent {
    for(UIView *view in self.subviews) {
        if([view isKindOfClass:[UIImageView class]]) [view removeFromSuperview];
    }
    
    for(NSDictionary *dict in _contentArray) {
//        UIImage *image = [UIImage imageNamed:dict[@"image"]];
//        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//        int x = [dict[@"x"] intValue];
//        int y = [dict[@"y"] intValue];
//        
//        [imageView setCenter:CGPointMake(x, y)];
//        [self addSubview:imageView];
    }
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
