//
// CIEConvolution3X3.h
// CoreImageFilterEnumeration
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterBase.h"

@interface CIEConvolution3X3 : CIEFilterBase

@property (strong, nonatomic) CIImage *inputImage;
@property (strong, nonatomic) CIVector *inputWeights;
@property (strong, nonatomic) NSNumber *inputBias;

@end