//
// CIEFilterEnumerator.m
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/9/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterEnumerator.h"
#import "CIEFilterDescriptor.h"

@import CoreImage;

@interface CIEFilterEnumerator ()

@end

@implementation CIEFilterEnumerator

+ (NSArray *)allFilterNames
{
    return [CIFilter filterNamesInCategories:nil];
}


+ (NSArray *)filterCategoryEffectTypeList
{
    static NSArray *_effectTypeCategories;
    if (!_effectTypeCategories) {
        _effectTypeCategories = @[];
    }
    return nil;
}

+ (NSArray *)filterCategoryIntentList
{
    return nil;
}

+ (BOOL)createEnumerationClasses
{
    NSArray *filterNames = [self allFilterNames];
    NSURL *baseURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    NSString *basePath = [baseURL path];
    NSLog(@"Putting class files here: %@", basePath);
    for (NSString *filterName in filterNames) {
        CIFilter *filter = [CIFilter filterWithName:filterName];
        CIEFilterDescriptor *filterDescriptor = [[CIEFilterDescriptor alloc] initWithFilter:filter];
        NSString *headerContent = [filterDescriptor headerDefinition];
        NSString *implementationContent = [filterDescriptor implementationDefinition];
        NSString *headerPath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.h", filterDescriptor.enumerationClassName]];
        NSString *implementationPath = [basePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.m", filterDescriptor.enumerationClassName]];
        NSError *error = nil;
        BOOL success;
        success = [headerContent writeToFile:headerPath atomically:NO encoding:NSUTF8StringEncoding error:&error];
        if (!success) {
            NSLog(@"Error creating header (.h) file for '%@': %@", filterDescriptor.enumerationClassName, error.localizedDescription);
            return NO;
        }
        success = [implementationContent writeToFile:implementationPath atomically:NO encoding:NSUTF8StringEncoding error:&error];
        if (!success) {
            NSLog(@"Error creating implementation (.m) file for '%@': %@", filterDescriptor.enumerationClassName, error.localizedDescription);
            return NO;
        }
    }
    return YES;
}


@end
