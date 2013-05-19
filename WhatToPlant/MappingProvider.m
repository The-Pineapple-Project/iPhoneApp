//
//  MappingProvider.m
//  WhatToPlant
//
//  Created by aash on 2013-05-18.
//  Copyright (c) 2013 The Pineapple Project. All rights reserved.
//

#import "MappingProvider.h"
#import "Geolookup.h"

@implementation MappingProvider

+ (RKMapping *)geolookupMapping
{
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Geolookup class]];
    [mapping addAttributeMappingsFromDictionary:@{
        @"location.country": @"country",
        @"location.state": @"province",
        @"location.city": @"city",
        @"location.requesturl": @"requestURL"
     }];
    return mapping;
}
@end
