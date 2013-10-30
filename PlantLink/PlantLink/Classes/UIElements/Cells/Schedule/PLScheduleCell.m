//
//  PLScheduleCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 10/24/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//


#import "PLScheduleCell.h"


@implementation PLScheduleCell

-(id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.contentView.layer setBorderColor:Color_CellBorder.CGColor];
        [self setClipsToBounds:NO];
        [self.layer setCornerRadius:3.0];
        [self addLabels];
    }
    return self;
}

-(void)addLabels {
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 20, 150, 45)];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:23.0]];
    [nameLabel setTextColor:[UIColor blackColor]];
    [self addSubview:nameLabel];
    
    dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 49, 91, 21)];
    [dateLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:15.0]];
    [dateLabel setTextColor:[UIColor blackColor]];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:dateLabel];
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 14, 91, 34)];
    [dayLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:28.0]];
    [dayLabel setTextColor:[UIColor blackColor]];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:dayLabel];
    
    separatorView = [[UIView alloc] initWithFrame:CGRectMake(110, 14, 1, 57)];
    [separatorView setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:separatorView];
    
}

#pragma mark -
#pragma mark Set Methods

-(void)setDictionary:(NSDictionary*)dict {
    
    
    [nameLabel setText:[dict objectForKey:@"name"]];
    NSDate *cellDate = [dict objectForKey:@"date"];
    
    
    NSString *dayStr = [GeneralMethods stringFromDate:cellDate withFormat:@"EEE"];
    NSString *monthStr = [GeneralMethods stringFromDate:cellDate withFormat:@"MMM dd"];
    
    [dayLabel setText:dayStr];
    [dateLabel setText:monthStr];
    if([self distanceFromToday:cellDate] == 0){
        [dayLabel setText:@"Today"];
        [self setBackgroundColor:[UIColor redColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [dayLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [separatorView setBackgroundColor:[UIColor whiteColor]];
        
    }else{
        [self setBackgroundColor:[UIColor whiteColor]];
        [nameLabel setTextColor:[UIColor blackColor]];
        [dayLabel setTextColor:[UIColor blackColor]];
        [dateLabel setTextColor:[UIColor blackColor]];
        [separatorView setBackgroundColor:[UIColor lightGrayColor]];
    }
}

#pragma mark -
#pragma mark Date Methods

-(int)distanceFromToday:(NSDate*)date {
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:[NSDate date] toDate:date options:0];
    
    return [components day];
}


#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(297, 85);
}

@end
