//
//  ApplicationModel.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 13/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "ApplicationModel.h"
@implementation ApplicationModel
static ApplicationModel *singletonInstance = nil;

+ (ApplicationModel *) sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[ApplicationModel alloc] init];
        singletonInstance.imageCache = [[NSCache alloc]init];
        singletonInstance.pageCount = 0;
    });
    return singletonInstance;
}

-(void)setCurrentCity:(City *)currentCity
{
    if ([currentCity.cityId isEqualToString:_currentCity.cityId] == NO) {
        [self clearModel];
    }
    else
    {
        if (currentCity.currentWeather == nil && currentCity.forecast.count > 0) {
            currentCity.currentWeather = _currentCity.currentWeather;
        }
    }
    _currentCity = currentCity;
}

- (void)clearModel
{
    singletonInstance.imageCache = [[NSCache alloc]init ];
    singletonInstance.pageCount = 0;
}
@end
