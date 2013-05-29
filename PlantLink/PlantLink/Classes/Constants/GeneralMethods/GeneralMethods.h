//
//  GeneralMethods.h
//  Zealous Amoeba
//
//  Created by Zealous Amoeba on 5/25/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeneralMethods : NSObject

#pragma mark -
#pragma mark Color Methods

+(UIColor*)colorFromHexString:(NSString*)hex;
+(CGFloat)colorComponentFrom:(NSString *)string start:(NSUInteger)start length:(NSUInteger)length;

#pragma mark -
#pragma mark Date Methods

+(NSString*)stringFromDate:(NSDate*)date withFormat:(NSString*)format;
+(NSDate*)dateFromStandardDateString:(NSString*)dateStr;
+(NSDateComponents*)componentsFromDate:(NSDate*)date;

#pragma mark -
#pragma mark Macros

#define NSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define ZALog(format,...) NSLog((@"%s [Line %d] " format), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

@end
