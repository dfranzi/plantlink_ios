//
//  PLScheduleCell.m
//  PlantLink
//
//  Created by Zealous Amoeba on 10/24/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//


#import "PLScheduleCell.h"
#import "PLPlantModel.h"
#import "PLPlantMeasurementModel.h"

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
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(127, 10, 150, 65)];
    [nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:23.0]];
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setAdjustsFontSizeToFitWidth:YES];
    [nameLabel setMinimumScaleFactor:0.8];
    [nameLabel setNumberOfLines:0];
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

-(void)setPlant:(PLPlantModel *)plant {
    _plant = plant;
    
    [nameLabel setText:[_plant name]];
    NSDate *cellDate = [[_plant lastMeasurement] predictedWaterDate];
    if(cellDate == NULL) {
        [dayLabel setText:@"-_-"];
        [dateLabel setText:@"No link"];
        
        [self setBackgroundColor:[UIColor blueColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [dayLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [separatorView setBackgroundColor:[UIColor whiteColor]];
    }
    else if([self distanceFromToday:cellDate] == 0){
        NSString *dayStr = [GeneralMethods stringFromDate:[NSDate date] withFormat:@"EEE"];
        NSString *monthStr = [GeneralMethods stringFromDate:[NSDate date] withFormat:@"MMM dd"];
        
        [dayLabel setText:dayStr];
        [dateLabel setText:monthStr];
        
        [dayLabel setText:@"Today"];
        [self setBackgroundColor:[UIColor redColor]];
        [nameLabel setTextColor:[UIColor whiteColor]];
        [dayLabel setTextColor:[UIColor whiteColor]];
        [dateLabel setTextColor:[UIColor whiteColor]];
        [separatorView setBackgroundColor:[UIColor whiteColor]];
        
    }else{
        NSString *dayStr = [GeneralMethods stringFromDate:cellDate withFormat:@"EEE"];
        NSString *monthStr = [GeneralMethods stringFromDate:cellDate withFormat:@"MMM dd"];
        
        [dayLabel setText:dayStr];
        [dateLabel setText:monthStr];
        
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
    
    if([[NSDate date] compare:date] == NSOrderedDescending) return 0;
    return [components day];
}


#pragma mark -
#pragma mark Size Methods

+(CGSize)sizeForContent:(NSDictionary*)content {
    return CGSizeMake(297, 85);
}

@end
