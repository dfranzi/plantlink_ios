//
//  PLTourCell.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "AbstractCLCell.h"

@interface PLTourCell : AbstractCLCell {
    IBOutlet UIView *contentsView;
    IBOutlet UIPageControl *cellPageControl;
}

#pragma mark -
#pragma mark Page Control Methods

-(void)setPage:(int)page ofTotal:(int)total;

@end
