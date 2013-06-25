//
//  PLTextField.h
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PLTextField : UITextField

#pragma mark -
#pragma mark View Methods

-(void)setLeftLabel:(NSString*)labelText;
-(void)setRightInfoWithTitle:(NSString*)title text:(NSString*)text andCancelButton:(NSString*)cancel;


@end
