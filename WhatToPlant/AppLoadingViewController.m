//
//  AppLoadingViewController.m
//  WhatToPlant
//
//  Created by aash on 2013-05-18.
//  Copyright (c) 2013 The Pineapple Project. All rights reserved.
//

#import "AppLoadingViewController.h"
#import "Geolookup.h"
#import <RestKit/RestKit.h>
#import "MappingProvider.h"
#import "SVProgressHUD.h"

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
        
        [progressText setText:@"finding your location"];
        
        // Start finding location
        [locationManager startUpdatingLocation];
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    CLLocation *loc = locations[0];
    NSLog(@"%@", loc);
    [locationManager stopUpdatingLocation];
    
    [SVProgressHUD show];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self loadClimateDataForCoordinate:[loc coordinate]];
    });

}

- (void)loadClimateDataForCoordinate:(CLLocationCoordinate2D)coordinate
{
    // API: Weather Underground
    // http:// api.wunderground.com/api/81cd84db7bf69b83/geolookup/q/37.776289,-122.395234.json
    NSIndexSet *statusCodeSet = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKMapping *mapping = [MappingProvider geolookupMapping];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:mapping
                                                pathPattern:nil
                                                keyPath:nil
                                                statusCodes:statusCodeSet];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.wunderground.com/api/%@/geolookup/q/%f,%f.json",
                                       WUNDERGROUND_API_KEY,
                                       coordinate.latitude,
                                       coordinate.longitude
                                       ]];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    RKObjectRequestOperation *operation = [[RKObjectRequestOperation alloc] initWithRequest:req
                                                                        responseDescriptors:@[responseDescriptor]];
    
    [operation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"SUCCESS! Response: %@", mappingResult.array);
        [SVProgressHUD dismiss];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
        NSLog(@"Response: %@", operation.HTTPRequestOperation.responseString);
        [SVProgressHUD showErrorWithStatus:@"Request failed"];
    }];
    
    [operation start];
    
    
    // response details @ http://www.wunderground.com/weather/api/d/docs?d=data/geolookup
    
    // API: Google Maps for iOS
    // --CUT-- can't be used as a JSON REST service, it makes calls locally instead, so not good as a placeholder until our server-side API is ready
    // https://developers.google.com/maps/documentation/ios/start
    // Key for iOS apps (with bundle identifiers)
    //  API key: AIzaSyC6tiz15CK6NIfKKhEdbeKOiy-cyDTUrj8
    //  iOS apps: com.thepineappleproject.WhatToPlant
    //  Activated on:	May 18, 2013 4:27 PM
    //  Activated by:	 enderash@gmail.com – you
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
