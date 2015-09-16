//
//  CityWeatheBuilder.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 13/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "CityWeatherBuilder.h"
#import "Weather.h"
@implementation CityWeatherBuilder
+(City*)buildCityWeatherWithJSON:(id)cityWeatherJSON
{
    City * city = [[City alloc]init];
    city.currentWeather = [[Weather alloc]init];
    
    id value = [cityWeatherJSON valueForKey:@"coord"];
    if (value!= nil && value != [NSNull null]) {
        id lon = [value valueForKey:@"lon"];
        id lat = [value valueForKey:@"lat"];
        if (lon!= nil && lon!= [NSNull null] && lat != nil && lat!= [NSNull null])
        {
            city.cityCoordinates = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
        }
    }
    
    value = [cityWeatherJSON valueForKey:@"name"];
    if (value!=nil && value != [NSNull null]) {
        city.cityName = value;
    }
    
    value = [cityWeatherJSON valueForKey:@"id"];
    if (value!=nil && value != [NSNull null]) {
        city.cityId = [value stringValue];
    }
    
    value = [cityWeatherJSON valueForKey:@"main"];
    if (value!=nil && value != [NSNull null]) {
        id subValue = [value valueForKey:@"temp"];
        if (subValue!=nil && subValue!=[NSNull null]) {
            city.currentWeather.temperature = [NSString stringWithFormat:@"%ld",(long)[subValue integerValue]];
        }
        
        subValue = [value valueForKey:@"humidity"];
        if (subValue!=nil && subValue!=[NSNull null]) {
            city.currentWeather.humidity = [subValue stringValue];
        }
        
        subValue = [value valueForKey:@"temp_max"];
        if (subValue!=nil && subValue!=[NSNull null]) {
            city.currentWeather.temperatureMax = [subValue stringValue];
        }
        
        subValue = [value valueForKey:@"temp_min"];
        if (subValue!=nil && subValue!=[NSNull null]) {
            city.currentWeather.temperatureMin = [subValue stringValue];
        }
    }
    
    value = [cityWeatherJSON valueForKey:@"weather"];
    if (value!=nil && value != [NSNull null ] && [value isKindOfClass:[NSArray class]] && [((NSArray*)value) count]>0)
    {
        id subValue = ((NSArray*)value)[0];
        id subSubValue = [subValue valueForKey:@"main"];
        if (subSubValue != nil && subSubValue != [NSNull null])
        {
            city.currentWeather.weatherDesciption = subSubValue;
        }
        
        subSubValue = [subValue valueForKey:@"icon"];
        if (subSubValue != nil && subSubValue != [NSNull null])
        {
            city.currentWeather.iconId = subSubValue;
        }
    }
    
    value = [cityWeatherJSON valueForKey:@"wind"];
    if (value!=nil && value != [NSNull null ])
    {
        id speed = [value valueForKey:@"speed"];
        id deg = [value valueForKey:@"deg"];
        if (speed!=nil && speed != [NSNull null] && deg!= nil && deg != [NSNull null])
        {
            NSUInteger degree = [deg integerValue];
            NSString * direction = [CityWeatherBuilder getWindDirectionFromDegree:degree];
            city.currentWeather.windDirection = [NSString stringWithFormat:@"%@ m/s %@",[speed stringValue],direction];
        }
    }
    
    value = [cityWeatherJSON valueForKey:@"dt"];
    if (value!=nil && value!= [NSNull null])
    {
        city.currentWeather.date = [NSDate dateWithTimeIntervalSince1970:[value integerValue]];
    }
    
    return city;
}

+(City*)buildForecastCityWeatherWithJSON:(id)cityWeatherJSON
{
    City * city = [[City alloc]init];
    id value = [cityWeatherJSON valueForKey:@"city"];
    if (value!= nil && value!=[NSNull null])
    {
        id subValue = [value valueForKey:@"name"];
        if (subValue!=nil && subValue != [NSNull null]) {
            city.cityName = subValue;
        }
        
        subValue = [value valueForKey:@"id"];
        if (subValue!=nil && subValue != [NSNull null]) {
            city.cityId = [subValue stringValue];
        }
        
        subValue = [value valueForKey:@"coord"];
        if (subValue!= nil && subValue != [NSNull null]) {
            id lon = [subValue valueForKey:@"lon"];
            id lat = [subValue valueForKey:@"lat"];
            if (lon!= nil && lon!= [NSNull null] && lat != nil && lat!= [NSNull null])
            {
                city.cityCoordinates = CLLocationCoordinate2DMake([lat doubleValue], [lon doubleValue]);
            }
        }
    }
    
    value = [cityWeatherJSON valueForKey:@"list"];
    if (value!= nil && value != [NSNull null] && [value isKindOfClass:[NSArray class]] && ((NSArray*)value).count>0)
    {
        for (id weatherObject in value)
        {
            Weather * weather = [[Weather alloc]init];
            id subValue;
            subValue = [weatherObject valueForKey:@"dt"];
            if (subValue!=nil && subValue!= [NSNull null])
            {
                weather.date = [NSDate dateWithTimeIntervalSince1970:[subValue integerValue]];
            }
            
            subValue = [weatherObject valueForKey:@"temp"];
            if (subValue!=nil && subValue!= [NSNull null])
            {
                id subSubValue = [subValue valueForKey:@"min"];
                if (subSubValue != nil && subSubValue != [NSNull null])
                {
                    weather.temperatureMin = [NSString stringWithFormat:@"%ld",(long)[subSubValue integerValue]];
                }
                
                subSubValue = [subValue valueForKey:@"max"];
                if (subSubValue != nil && subSubValue != [NSNull null])
                {
                    weather.temperatureMax = [NSString stringWithFormat:@"%ld",(long)[subSubValue integerValue]];
                }
            }
            
            subValue = [weatherObject valueForKey:@"humidity"];
            if (subValue!=nil && subValue!= [NSNull null])
            {
                weather.humidity = [subValue stringValue];
            }
            
            subValue = [weatherObject valueForKey:@"weather"];
            if (subValue!=nil && subValue != [NSNull null ] && [subValue isKindOfClass:[NSArray class]] && [((NSArray*)subValue) count]>0)
            {
                id subSubValue = ((NSArray*)subValue)[0];
                id main = [subSubValue valueForKey:@"main"];
                if (main!=nil && main!= [NSNull null]) {
                    weather.weatherDesciption = main;
                }
                
                main = [subSubValue valueForKey:@"icon"];
                if (main!=nil && main!= [NSNull null]) {
                    weather.iconId = main;
                }
            }
            
            id speed = [weatherObject valueForKey:@"speed"];
            id deg = [weatherObject valueForKey:@"deg"];
            if (speed!=nil && speed != [NSNull null] && deg!= nil && deg != [NSNull null])
            {
                NSUInteger degree = [deg integerValue];
                NSString * direction = [CityWeatherBuilder getWindDirectionFromDegree:degree];
                weather.windDirection = [NSString stringWithFormat:@"%@ m/s %@",[speed stringValue],direction];
            }
            [city.forecast addObject:weather];
        }
    }
    return city;
}

+(NSString*)getWindDirectionFromDegree:(NSUInteger)degree
{
    NSString * direction;
    if (degree == 0) {
        direction = @"E";
    }
    else if (degree>0 && degree<90)
    {
        direction = @"NE";
    }
    else if (degree == 90)
    {
        direction = @"N";
    }
    else if (degree>90 && degree<180)
    {
        direction = @"NW";
    }
    else if (degree == 180)
    {
        direction = @"W";
    }
    else if (degree > 180 && degree < 270)
    {
        direction = @"SW";
    }
    else if (degree == 270)
    {
        direction = @"S";
    }
    else
    {
        direction = @"SE";
    }
    return direction;
}
@end
