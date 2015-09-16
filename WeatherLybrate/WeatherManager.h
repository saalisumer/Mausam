//
//  WeatherManager.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "City.h"
typedef void(^CompletionBlock)(id object);
typedef void(^ErrorBlock)(NSError * error);
@interface WeatherManager : NSObject
+(WeatherManager*)sharedManager;
-(void)updateCurrentWeatherForPlacemark:(CLPlacemark *)placemark withCompletion:(CompletionBlock)completion andError:(ErrorBlock)errorBlock;
-(void)updateCurrentWeatherForPlace:(NSString *)place withCompletion:(CompletionBlock)completion andError:(ErrorBlock)errorBlock;
-(void)fetchWeatherForecastForCity:(City *)city withCompletion:(CompletionBlock)completion andError:(ErrorBlock)errorBlock;
@end
