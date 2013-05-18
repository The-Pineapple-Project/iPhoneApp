//
//  AppLoadingViewController.m
//  WhatToPlant
//
//  Created by aash on 2013-05-18.
//  Copyright (c) 2013 The Pineapple Project. All rights reserved.
//

#import "AppLoadingViewController.h"

@interface AppLoadingViewController ()

@end

@implementation AppLoadingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Create location manager object
        locationManager = [[CLLocationManager alloc] init];
        
        // to start, let's try the highest accuracy setting, regardless of how much time/power it takes
        [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [locationManager setDelegate:self];
        
        // progress: Finished Step 1 (App is loaded). Step 2 is "request location"
        [progressBar setProgress:0.25 animated:YES];
        [progressText setText:@"finding your location"];
        
        // Start finding location
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *mostRecentLoc = locations[0];
    NSLog(@"%@", mostRecentLoc);
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorized)
    {
        // progress: Finished Step 2 (requesting location). Step 3 is "send request for climate data to our web service"
        [progressBar setProgress:0.50 animated:YES];
        [progressText setText:@"retrieving climate data"];
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@", error);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealloc
{
    // Tell the location manager to stop sending us messages
    [locationManager setDelegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
