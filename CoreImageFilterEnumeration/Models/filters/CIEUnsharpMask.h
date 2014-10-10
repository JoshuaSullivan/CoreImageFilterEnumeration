//
// CIEUnsharpMask.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEUnsharpMask : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) NSNumber *inputRadius;
@property (strong, nonatomic) NSNumber *inputIntensity;

@end
