//
// CIEFilterPropertyDescriptor.m
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterPropertyDescriptor.h"
@import CoreImage;

static NSString * const kInputPropertyTemplate = @"@property (strong, nonatomic) %@ *%@;";
static NSString * const kOutputPropertyTemplate = @"@property (readonly, nonatomic) %@ %@;";

static NSString * const kOutputDataKey = @"outputData";
static NSString * const kOutputCGImageKey = @"outputCGImage";

@interface CIEFilterPropertyDescriptor ()

@property (strong, nonatomic) NSString *propName;
@property (strong, nonatomic) NSString *classType;
@property (assign, nonatomic) BOOL isInputProperty;

@end

@implementation CIEFilterPropertyDescriptor

- (instancetype)initWithPropertyName:(NSString *)propName
                 attributeDictionary:(NSDictionary *)attributeDictionary
                     isInputProperty:(BOOL)isInputProperty
{
    self = [super init];
    if (self) {
        _propName = propName;
        _isInputProperty = isInputProperty;
        if (isInputProperty) {
            _classType = attributeDictionary[kCIAttributeClass];
        } else {
            _classType = [self getClassTypeForOutputKey:propName];
        }

    }
    return self;
}

- (NSString *)description
{
    NSString *format = self.isInputProperty ? kInputPropertyTemplate : kOutputPropertyTemplate;
    return [NSString stringWithFormat:format, self.classType, self.propName];
}

- (NSString *)getClassTypeForOutputKey:(NSString *)outputKey
{
    if ([outputKey isEqualToString:kOutputDataKey]) {
        return @"NSData *";
    }
    else if ([outputKey isEqualToString:kOutputCGImageKey]) {
        return @"CGImageRef";
    }
    NSLog(@"What fresh hell is this!? Don't have a value for key '%@'.", outputKey);
    return nil;
}

@end
