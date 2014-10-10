//
// CIEFilterPropertyDescriptor.h
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import <Foundation/Foundation.h>

@interface CIEFilterPropertyDescriptor : NSObject

@property (readonly, nonatomic) NSString *propName;
@property (readonly, nonatomic) NSString *classType;
@property (readonly, nonatomic) BOOL isInputProperty;

- (instancetype)initWithPropertyName:(NSString *)propName
                 attributeDictionary:(NSDictionary *)attributeDictionary
                     isInputProperty:(BOOL)isInputProperty;

@end
