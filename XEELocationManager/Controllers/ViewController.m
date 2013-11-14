//
//  ViewController.m
//  XEELocationManager
//
//  Created by Andrija Cajic on 14/11/13.
//  Copyright (c) 2013 Andrija Cajic. All rights reserved.
//

#import "ViewController.h"
#import "XEELocationManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[XEELocationManager sharedManager] fetchCurrentLocation:^(CLLocation *location) {
        NSLog(@"%@", location);
    } refresh:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
