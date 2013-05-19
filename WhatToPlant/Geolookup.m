//
//  Geolookup.m
//  WhatToPlant
//
//  Created by aash on 2013-05-18.
//  Copyright (c) 2013 The Pineapple Project. All rights reserved.
//

#import "Geolookup.h"

@implementation Geolookup
-(NSString *)description
{
    return [NSString stringWithFormat:@"Country: %@    Province: %@    City: %@",
            self.country,
            self.province,
            self.city];
}
@end
