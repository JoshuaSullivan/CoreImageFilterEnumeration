//
// CIEFilterDescriptor.m
// CoreImageVideoTestbed
//
// Created by Joshua Sullivan on 10/10/14.
// Copyright (c) 2014 Joshua Sullivan. All rights reserved.


#import "CIEFilterDescriptor.h"
#import "CIEFilterPropertyDescriptor.h"

static NSString *kHeaderTemplate;
static NSString *kImplementationTemplate;
static NSDateFormatter *kCreationDateFormatter;
static NSString * const kCreatorName = @"Joshua Sullivan";

@interface CIEFilterDescriptor ()

@property (strong, nonatomic) NSString *filterName;
@property (strong, nonatomic) NSString *enumerationClassName;
@property (strong, nonatomic) NSString *displayName;
@property (strong, nonatomic) NSArray *inputProperties;
@property (strong, nonatomic) NSArray *outputProperties;
@property (strong, nonatomic) NSArray *filterCategories;


@property (strong, nonatomic) CIFilter *filter;

@end

@implementation CIEFilterDescriptor

- (instancetype)initWithFilter:(CIFilter *)filter
{
    self = [super init];
    if (self) {
        _filter = filter;
        [self parseAttributeDictionary];
        if (!kCreationDateFormatter) {
            kCreationDateFormatter = [[NSDateFormatter alloc] init];
            kCreationDateFormatter.dateStyle = NSDateFormatterShortStyle;
        }
    }
    return self;
}

- (void)parseAttributeDictionary
{
    NSDictionary *attributes = self.filter.attributes;
    NSArray *inputKeys = self.filter.inputKeys;

    self.filterName = self.filter.name;
    NSString *unNamespacedFilterName = [self.filterName substringFromIndex:2];
    self.enumerationClassName = [NSString stringWithFormat:@"CIE%@", unNamespacedFilterName];
    self.displayName = attributes[kCIAttributeFilterDisplayName];
    self.filterCategories = attributes[kCIAttributeFilterCategories];
    NSMutableArray *inputs = [NSMutableArray arrayWithCapacity:inputKeys.count];
    for (NSString *inputKey in inputKeys) {
        CIEFilterPropertyDescriptor *prop = [[CIEFilterPropertyDescriptor alloc] initWithPropertyName:inputKey attributeDictionary:attributes[inputKey] isInputProperty:YES];
        [inputs addObject:prop];
    }
    self.inputProperties = [NSArray arrayWithArray:inputs];

    NSArray *outputKeys = self.filter.outputKeys;
    if (outputKeys.count > 1) {
//        NSLog(@"More than one outputKey found on filter %@", self.filterName);
        NSMutableArray *outputs = [NSMutableArray arrayWithCapacity:(outputKeys.count - 1)];
        for (NSString *outputKey in outputKeys) {
            if ([outputKey isEqualToString:kCIOutputImageKey]) {
                continue;
            }
            CIEFilterPropertyDescriptor *prop = [[CIEFilterPropertyDescriptor alloc] initWithPropertyName:outputKey attributeDictionary:attributes[outputKey] isInputProperty:NO];
            [outputs addObject:prop];
        }
        self.outputProperties = [NSArray arrayWithArray:outputs];
    }
}

- (NSString *)headerDefinition
{
    if (!kHeaderTemplate) {
        NSString *headerTemplatePath = [[NSBundle mainBundle] pathForResource:@"FilterHeaderTemplate" ofType:@"txt"];
        kHeaderTemplate = [NSString stringWithContentsOfFile:headerTemplatePath encoding:NSUTF8StringEncoding error:nil];
    }
    NSString *className = self.enumerationClassName;
    NSString *creationDate = [kCreationDateFormatter stringFromDate:[NSDate date]];
    NSString *propertyList = [self propertyList];
    NSString *headerString = [NSString stringWithFormat:kHeaderTemplate,
                                                        className, // Class name
                                                        kCreatorName, // Creator name
                                                        creationDate, // Creation date
                                                        kCreatorName, // Copyright
                                                        className, // Class name
                                                        propertyList // List of input and output properties.
    ];
    return headerString;
}

- (NSString *)propertyList
{
    NSString *propString = [self.inputProperties componentsJoinedByString:@"\n"];
    if (self.outputProperties) {
        propString = [NSString stringWithFormat:@"%@\n\n%@", propString, [self.outputProperties componentsJoinedByString:@"\n"]];
    }
    return propString;
}

- (NSString *)implementationDefinition
{
    if (!kImplementationTemplate) {
        NSString *implementationTemplatePath = [[NSBundle mainBundle] pathForResource:@"FilterImplementationTemplate" ofType:@"txt"];
        kImplementationTemplate = [NSString stringWithContentsOfFile:implementationTemplatePath encoding:NSUTF8StringEncoding error:nil];
    }
    NSString *className = self.enumerationClassName;
    NSString *creationDate = [kCreationDateFormatter stringFromDate:[NSDate date]];
    NSString *implString = [NSString stringWithFormat:kImplementationTemplate,
                                                      className,
                                                      kCreatorName,
                                                      creationDate,
                                                      kCreatorName,
                                                      className,
                                                      className,
                                                      self.filterName
    ];
    return implString;
}


@end
