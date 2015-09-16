//
//  Weather.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "Weather.h"

@implementation Weather
- (instancetype)init
{
    self = [super init];
    if (self) {
        _date = [NSDate date];
        _temperature = @"";
        _temperatureMax = @"";
        _temperatureMin = @"";
        _humidity = @"";
        _iconId = @"";
        _windDirection = @"";
    }
    return self;
}
@end
