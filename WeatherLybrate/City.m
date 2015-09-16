//
//  City.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "City.h"

@implementation City
- (instancetype)init
{
    self = [super init];
    if (self) {
        _cityId = @"";
        _cityName = @"";
        _cityCoordinates = CLLocationCoordinate2DMake(0, 0);
        _forecast = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
