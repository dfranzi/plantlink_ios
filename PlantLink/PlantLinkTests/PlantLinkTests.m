//
//  PlantLinkTests.m
//  PlantLinkTests
//
//  Created by Zealous Amoeba on 5/28/13.
//  Copyright (c) 2013 Zealous Amoeba. All rights reserved.
//

#import "PlantLinkTests.h"
#import "AbstractModel.h"

#import "PLUserRequest.h"

@implementation PlantLinkTests

-(void)setUp {
    [super setUp];
}

-(void)tearDown {
    [super tearDown];
}

#pragma mark -
#pragma mark Model Tests

/*
 * Tests all the models specified in ModelTests.strings
 */
-(void)testModels {
    // Finds, loads, and serializes the JSON strings file into an NSarray
    NSBundle *unitTestBundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [unitTestBundle pathForResource:@"ModelTests" ofType:@"strings"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    // Prints which models will be tested
    ZALog(@"\n\n");
    for(NSDictionary *dict in array) {
        ZALog(@"* Will test model: %@ *",dict[@"class"]);
    }
    ZALog(@"\n");
    
    // For every model to test
    for(NSDictionary *dict in array) {
        Class modelClass = NSClassFromString(dict[@"class"]);
        NSDictionary *modelDict = dict[@"model"];
        
        // Create the model by parsing, copying, and unarchiving after archiving
        AbstractModel *model = [[modelClass alloc] initWithDictionary:modelDict];
        AbstractModel *copy = [model copy];

        NSData *modelData = [NSKeyedArchiver archivedDataWithRootObject:model];
        AbstractModel *archive = [NSKeyedUnarchiver unarchiveObjectWithData:modelData];
        
        // Test the archive and copy models for validity
        STAssertTrue([model isEqual:copy], @"    Copy equals test");
        STAssertTrue([model isEqual:archive], @"    Archive equals test");
        
        ZALog(@"*** Testing class: %@ ***",dict[@"class"]);
        
        NSDictionary *keys = dict[@"keys"];
        for(NSString *key in [dict[@"keys"] allKeys]) {
            NSString *param = keys[key];
            id value = [model valueForKey:key];
            ZALog(@"    Testing key: %@ with original model value %@",key,modelDict[param]);
            
            NSString *testParse = [NSString stringWithFormat:@"   * Parse test: %@",key];
            NSString *testArchive = [NSString stringWithFormat:@"   * Archive test: %@",key];
            NSString *testCopy = [NSString stringWithFormat:@"   * Copy test: %@",key];
            
            STAssertEqualObjects(value, [copy valueForKey:key], testCopy);
            STAssertEqualObjects(value, [archive valueForKey:key], testArchive);
            ZALog(@"    Testing archive key: %@",key);
            ZALog(@"    Testing copy key: %@",key);
            
            if([value isKindOfClass:[UIColor class]]) {
                id color = [GeneralMethods colorFromHexString:modelDict[param]];
                STAssertEqualObjects(value, color, testParse);
            }
            else if([value isKindOfClass:[NSDate class]]) {
                id date = [NSDate dateWithTimeIntervalSince1970:[modelDict[param] intValue]];
                STAssertEqualObjects(value, date, testParse);
            }
            else if([value isKindOfClass:[NSString class]]) {
                STAssertEqualObjects(value, modelDict[param], testParse);
            }
            else {
                STAssertEqualObjects([value description],[modelDict[param] description], testParse);
            }
        }
        ZALog(@"\n");
    }
}

@end
