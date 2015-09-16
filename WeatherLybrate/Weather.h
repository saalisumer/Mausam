//
//  Weather.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Weather : NSObject
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, strong) NSString * temperature;
@property (nonatomic, strong) NSString * temperatureMax;
@property (nonatomic, strong) NSString * temperatureMin;
@property (nonatomic, strong) NSString * humidity;
@property (nonatomic, strong) NSString * iconId;
@property (nonatomic, strong) NSString * windDirection;
@property (nonatomic, strong) NSString * weatherDesciption;
@end
