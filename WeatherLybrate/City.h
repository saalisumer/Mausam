//
//  City.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Weather.h"

@interface City : NSObject
@property (nonatomic, strong) NSString                      * cityId;
@property (nonatomic, strong) NSString                      * cityName;
@property (nonatomic, assign) CLLocationCoordinate2D          cityCoordinates;
@property (nonatomic, strong) Weather                       * currentWeather;
@property (nonatomic, strong) NSMutableArray                * forecast;


@end
