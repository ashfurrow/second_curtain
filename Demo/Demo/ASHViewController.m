//
//  ASHViewController.m
//  Demo
//
//  Created by Ash Furrow on 2014-07-23.
//  Copyright (c) 2014 Ash Furrow. All rights reserved.
//

#import "ASHViewController.h"

@interface ASHViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation ASHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.label.numberOfLines = 0;
    self.label.center = self.view.center;
    self.label.text = @"Some other text";
    [self.view addSubview:self.label];
}

@end
