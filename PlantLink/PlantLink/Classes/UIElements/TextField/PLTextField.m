//
//  PLTextField.m
//  PlantLink
//
//  Created by Zealous Amoeba on 6/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLTextField.h"
#import <QuartzCore/QuartzCore.h>

@interface PLTextField() {
@private
    NSString *_title;
    NSString *_text;
    NSString *_cancel;
}

@end

@implementation PLTextField

-(void)drawRect:(CGRect)rect {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:3.0f];
    
    CGRect _frame = self.frame;
    _frame.size = CGSizeMake(_frame.size.width+6, _frame.size.height);
    [self setFrame:_frame];
}

#pragma mark -
#pragma mark View Methods

-(void)setLeftLabel:(NSString*)labelText {
    [self setLeftViewMode:UITextFieldViewModeAlways];
    
    UIFont *font = [UIFont fontWithName:Font_Bariol_Bold size:20.0];
    CGSize textSize = [labelText sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 20, self.frame.size.height)];
    [leftLabel setBackgroundColor:[UIColor clearColor]];
    [leftLabel setText:labelText];
    [leftLabel setTextAlignment:NSTextAlignmentCenter];
    [leftLabel setFont:font];
    [leftLabel setTextColor:[UIColor whiteColor]];
    
    [self setFont:font];
    
    [self setLeftView:leftLabel];
}

-(void)setRightInfoWithTitle:(NSString*)title text:(NSString*)text andCancelButton:(NSString*)cancel {
    [self setRightViewMode:UITextFieldViewModeAlways];
    
    _title = title;
    _text = text;
    _cancel = cancel;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [view setBackgroundColor:[UIColor clearColor]];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton setCenter:view.center];
    [view addSubview:infoButton];
    [infoButton addTarget:self action:@selector(infoPushed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightView:view];
}

#pragma mark -
#pragma mark Action Methods

-(void)infoPushed:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title message:_text delegate:nil cancelButtonTitle:_cancel otherButtonTitles:nil];
    [alert show];
}

@end
