//
//  AppLoadingViewController.h
//  WhatToPlant
//
//  Created by aash on 2013-05-18.
//  Copyright (c) 2013 The Pineapple Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AppLoadingViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
    
    __weak IBOutlet UIImageView *logo;
    __weak IBOutlet UILabel *greeting;
    __weak IBOutlet UILabel *progressText;
}

@end
