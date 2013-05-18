//
//  AppLoadingViewController.h
//  WhatToPlant
//
//  Created by aash on 2013-05-18.
//  Copyright (c) 2013 The Pineapple Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppLoadingViewController : UIViewController
{
    __weak IBOutlet UIImageView *logo;
    __weak IBOutlet UILabel *greeting;
    __weak IBOutlet UIProgressView *progressBar;
    __weak IBOutlet UILabel *progressText;
}

@end