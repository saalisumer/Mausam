//
//  CityWeatheBuilder.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 13/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
@interface CityWeatherBuilder : NSObject
+(City*)buildCityWeatherWithJSON:(id)cityWeatherJSON;
+(City*)buildForecastCityWeatherWithJSON:(id)cityWeatherJSON;
@end
