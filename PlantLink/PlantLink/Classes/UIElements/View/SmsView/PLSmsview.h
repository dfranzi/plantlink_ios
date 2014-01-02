//
//  PLSmsView.h
//  PlantLink
//
//  Created by Robert Maciej Pieta on 1/1/14.
//  Copyright (c) 2014 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLSmsView : UIView
@property(nonatomic, strong, readonly) UIButton *removeButton;

#pragma mark -
#pragma mark Information Methods

-(void)setSmsInfoDict:(NSDictionary*)dict;

@end
