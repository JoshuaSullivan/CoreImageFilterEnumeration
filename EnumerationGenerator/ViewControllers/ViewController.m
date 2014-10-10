//
//  ViewController.m
//  CoreImageFilterEnumeration
//
//  Created by Joshua Sullivan on 10/10/14.
//  Copyright (c) 2014 Joshua Sullivan. All rights reserved.
//

#import "ViewController.h"
#import "CIEFilterEnumerator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    BOOL success = [CIEFilterEnumerator createEnumerationClasses];
    NSLog(@"Class creation success: %@", success ? @"YES" : @"NO");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
