//
//  PLSettingsCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 8/22/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PLSettingsCell.h"
#import "TestFlight.h"

@interface PLSettingsCell() {
@private
    UIColor *darkenedColor;
}

@end

@implementation PLSettingsCell

/**
 * Initializes the cell and initial parameters, also adds the subviews to give a flat 3D look
 */
-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView.layer setBorderColor:Color_CellBorder.CGColor];
        [self setClipsToBounds:YES];
        
        CGSize size = [PLSettingsCell sizeForContent:@{}];
        background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height-2)];
        [background setBackgroundColor:[UIColor whiteColor]];
        [background.layer setCornerRadius:3.0];
        [background setClipsToBounds:YES];
        [self.contentView insertSubview:background atIndex:0];
        
        backdrop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height+1)];
        [backdrop setBackgroundColor:Color_CellBorder];
        [backdrop.layer setCornerRadius:3.0];
        [backdrop setClipsToBounds:YES];
        [self.contentView insertSubview:backdrop belowSubview:background];
        
        originalCenter = self.contentView.center;
    }
    return self;
}

#pragma mark -
#pragma mark Display Methods

/**
 * Sets the title of the cell
 */
-(void)setTitle:(NSString*)title {
    [titleLabel setText:title];
}

/**
 * Sets the text of the info label of the cell
 */
-(void)setLabel:(NSString*)label {
    [infoLabel setText:label];
}

#pragma mark -
#pragma mark Request Methods

/**
 * Returns a boolean if there was an error in the request response, showing an alert if necessary
 */
-(BOOL)errorInRequestResponse:(NSDictionary*)dict {
    if([dict.allKeys containsObject:@"severity"] && [dict[@"severity"] isEqualToString:@"Error"]) {
        NSString *errorKey = dict[@"type_detail"];
        NSString *message = dict[@"message"];
        if([Error_Dict.allKeys containsObject:errorKey]) message = Error_Dict[errorKey];
        else {
            if([dict.allKeys containsObject:@"type"] && [dict.allKeys containsObject:@"type_detail"]) TFLog(@"Generic error occured on: (%@, %@) %@",dict[@"type"],dict[@"severity"],dict[@"type_detail"]);
        }
        
        [self displayAlertWithTitle:@"Uh oh" andMessage:message];
        return YES;
    }
    return NO;
}

/**
 * Displays an alerts with the passed in title and message
 */
-(void)displayAlertWithTitle:(NSString*)title andMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];
    
}

#pragma mark -
#pragma mark Override Methods

/**
 * Updates the cell when highlighted, moving the content down to give the appearance of a 3D push
 */
-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if(highlighted) {
        [self.contentView setCenter:CGPointMake(originalCenter.x, originalCenter.y+3)];
        [backdrop setAlpha:0.0];
    }
    else {
        [self.contentView setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        [backdrop setAlpha:1.0];
    }
}



#pragma mark -
#pragma mark Size Methods

/**
 * Returns the default size for a plant settings cell
 */
+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(295, 110);
}

@end
