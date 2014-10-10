//
// CIEFilterEnumerator.h
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/9/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import <Foundation/Foundation.h>


@interface CIEFilterEnumerator : NSObject

+ (NSArray *)allFilterNames;
+ (NSArray *)filterCategoryEffectTypeList;
+ (NSArray *)filterCategoryIntentList;

+ (BOOL)createEnumerationClasses;

@end
