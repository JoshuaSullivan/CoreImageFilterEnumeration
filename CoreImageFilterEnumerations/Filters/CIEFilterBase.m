//
// CIEFilterBase.m
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEFilterBase ()

@end

@implementation CIEFilterBase

- (instancetype)init
{
    self = (CIEFilterBase *)[CIFilter filterWithName:self.filterName];
    if (!self) {
        NSLog(@"ERROR: Unable to instantiate filter with name '%@'.", self.filterName);
    }
    return self;
}

- (BOOL)chainFromFilter:(CIEFilterBase *)filter
{
    if (!self.isChainable) {
        return NO;
    }
    [self setValue:filter.outputImage forKey:kCIInputImageKey];
    return YES;
}

- (NSString *)filterName
{
    NSAssert(NO, @"ERROR :: Child classes MUST override filterName to ensure proper instantiation.");
    return nil;
}

- (BOOL)isChainable
{
    return [self.inputKeys containsObject:kCIInputImageKey];
}


@end
