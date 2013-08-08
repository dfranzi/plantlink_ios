//
//  PLAbstractPlantDetailCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/4/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLAbstractPlantDetailCell.h"

@interface PLAbstractPlantDetailCell() {
@private
    UILabel *infoLabel;
    CGFloat infoLabelHeight;
    CGPoint contentViewCenter;
    
    BOOL infoMode;
    BOOL editMode;
}

@end

#define PlantInfoText_Font @"HelveticaNeue-Italic"
#define PlantInfoText_Color RGB(141.0,202.0,135.0)
#define PlantInfoText_FontSize 12.0

#define PlantInfo_BorderOffset 25

@implementation PLAbstractPlantDetailCell

#warning If cell not loaded when show info is pressed incorrect behavior occurs
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_Plant_Edit object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:Notification_Plant_Info object:nil];
        
        infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 50, 260, 10)];
        [infoLabel setText:@""];
        [infoLabel setNumberOfLines:0];
        [infoLabel setTextColor:PlantInfoText_Color];
        [infoLabel setFont:[UIFont fontWithName:PlantInfoText_Font size:PlantInfoText_FontSize]];
        [infoLabel setBackgroundColor:[UIColor clearColor]];
        [infoLabel setAlpha:0.0f];
        [infoLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:infoLabel];
        
        infoMode = NO;
        editMode = NO;
        
        bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(PlantInfo_BorderOffset, self.contentView.frame.size.height-1, self.contentView.frame.size.width-2*PlantInfo_BorderOffset, 1)];
        [bottomBorder setBackgroundColor:SHADE(224.0)];
        [bottomBorder setAlpha:0.5];
        [self.contentView addSubview:bottomBorder];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

#pragma mark -
#pragma mark Setters 

-(void)setInfoText:(NSString *)infoText {
    _infoText = infoText;
    
    if(_infoText && ![_infoText isEqualToString:@""]) {
        [infoLabel setText:_infoText];
        
        float width = self.contentView.frame.size.width-60;
        CGSize size = [_infoText sizeWithFont:infoLabel.font constrainedToSize:CGSizeMake(infoLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        infoLabelHeight = size.height;
        [infoLabel setFrame:CGRectMake(30, 50, width, size.height)];
        
        
        [infoContainerView setBackgroundColor:[UIColor clearColor]];

        [bottomBorder setFrame:CGRectMake(PlantInfo_BorderOffset, self.contentView.frame.size.height-1, self.contentView.frame.size.width-2*PlantInfo_BorderOffset, 1)];
    }
}

#pragma mark -
#pragma mark Notification Methods

-(void)receivedNotification:(NSNotification*)notification {
    if([[notification name] isEqualToString:Notification_Plant_Edit]) {
        NSNumber *object = (NSNumber*)[notification object];
        if([object boolValue]) [self showEdit];
        else [self hideEdit];
    }
    else if([[notification name] isEqualToString:Notification_Plant_Info]) {
        NSNumber *object = (NSNumber*)[notification object];
        if([object boolValue]) [self showInfo];
        else [self hideInfo];
    }
}

#pragma mark -
#pragma mark Display Methods

-(void)showInfo {
    if(infoMode) return;
    contentViewCenter = infoContainerView.center;
    [UIView animateWithDuration:0.3 animations:^{
        [infoContainerView setCenter:CGPointMake(contentViewCenter.x, contentViewCenter.y+infoLabelHeight)];
        [infoContainerView setAlpha:0.5];
        [infoLabel setAlpha:1.0f];
        
        [bottomBorder setCenter:CGPointMake(bottomBorder.center.x, bottomBorder.center.y+infoLabelHeight)];
    }];
    infoMode = YES;
}

-(void)hideInfo {
    if(!infoMode) return;
    
    [UIView animateWithDuration:0.3 animations:^{
        [infoContainerView setCenter:contentViewCenter];
        [infoLabel setAlpha:0.0f];
        [infoContainerView setAlpha:1.0];
        
         [bottomBorder setFrame:CGRectMake(PlantInfo_BorderOffset, self.contentView.frame.size.height-1, self.contentView.frame.size.width-2*PlantInfo_BorderOffset, 1)];
    }];
    infoMode = NO;
}

-(void)showEdit {
    if(editMode) return;
    editMode = YES;
}

-(void)hideEdit {
    if(!editMode) return;
    editMode = NO;
}

#pragma mark -
#pragma mark Size Methods

+(CGFloat)heightForContent:(NSDictionary*)content {
    CGFloat heightAddition = 0;
    if(content[PlantInfo_InfoMode] && [content[PlantInfo_InfoMode] boolValue]) {
        NSString *infoText = content[PlantInfo_InfoText];
        CGSize size = [infoText sizeWithFont:[UIFont fontWithName:PlantInfoText_Font size:PlantInfoText_FontSize] constrainedToSize:CGSizeMake(260, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        heightAddition = size.height;
    }
    return heightAddition;
}


@end
