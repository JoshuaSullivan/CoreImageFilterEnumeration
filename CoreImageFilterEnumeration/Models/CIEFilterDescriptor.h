//
// CIEFilterDescriptor.h
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import <Foundation/Foundation.h>
@import CoreImage;

@interface CIEFilterDescriptor : NSObject

@property (readonly, nonatomic) NSString *filterName;
@property (readonly, nonatomic) NSString *enumerationClassName;
@property (readonly, nonatomic) NSString *displayName;
@property (readonly, nonatomic) NSArray *inputProperties;
@property (readonly, nonatomic) NSArray *outputProperties;
@property (readonly, nonatomic) NSArray *filterCategories;

- (NSString *)headerDefinition;
- (NSString *)implementationDefinition;

- (instancetype)initWithFilter:(CIFilter *)filter;

@end
