//
//  GeneralMethods.m
//  Zealous Amoeba
//
//  Created by Zealous Amoeba on 5/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "GeneralMethods.h"

@implementation GeneralMethods

#pragma mark -
#pragma mark Color Methods

+(UIColor*)colorFromHexString:(NSString*)hex { 
    float red   = [GeneralMethods colorComponentFrom:hex start:0 length:2];
    float green = [GeneralMethods colorComponentFrom:hex start:2 length:2];
    float blue  = [GeneralMethods colorComponentFrom:hex start:4 length:2];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+(CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length {
    NSString *substring = [string substringWithRange:NSMakeRange(start, length)];
    
    unsigned hexComponent;
    [[NSScanner scannerWithString:substring] scanHexInt:&hexComponent];
    return hexComponent / 255.0;
}

#pragma mark -
#pragma mark Date Methods

+(NSString*)stringFromDate:(NSDate*)date withFormat:(NSString*)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

+(NSDate*)dateFromStandardDateString:(NSString*)dateStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:dateStr];
}

+(NSDateComponents*)componentsFromDate:(NSDate*)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit|NSDayCalendarUnit|NSMonthCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit fromDate:date];
    return dateComponents;
}

@end
