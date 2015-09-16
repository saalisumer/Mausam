//
//  WeatherManager.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "WeatherManager.h"
#import "AFNetworking/AFNetworking.h"
#import "Constants.h"
#import "CityWeatherBuilder.h"
#import "ApplicationModel.h"
#import <UIKit/UIKit.h>

@interface WeatherManager()
{
    ApplicationModel                            * mApplicationModel;
}
@end

@implementation WeatherManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        mApplicationModel = [ApplicationModel sharedInstance];
    }
    return self;
}

+(WeatherManager*)sharedManager
{
    static WeatherManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WeatherManager alloc]init];
    });
    return sharedManager;
}


-(void)updateCurrentWeatherForPlacemark:(CLPlacemark *)placemark withCompletion:(CompletionBlock)completion andError:(ErrorBlock)errorBlock;
{
    NSString *string = [[NSString stringWithFormat:@"%@%@?q=%@&units=metric&APPID=%@", kBaseURL,kUrlCurrentWeather,placemark.name,kOpenWeatherAPIKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        City * city = [CityWeatherBuilder buildCityWeatherWithJSON:responseObject];
        mApplicationModel.currentCity = city;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(responseObject);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            errorBlock(error);
        });
    }];
    
    [operation start];
}

-(void)updateCurrentWeatherForPlace:(NSString *)place withCompletion:(CompletionBlock)completion andError:(ErrorBlock)errorBlock
{
    NSString *string = [[NSString stringWithFormat:@"%@%@?q=%@&units=metric&APPID=%@", kBaseURL,kUrlCurrentWeather,place,kOpenWeatherAPIKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        City * city = [CityWeatherBuilder buildCityWeatherWithJSON:responseObject];
        mApplicationModel.currentCity = city;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(responseObject);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            errorBlock(error);
        });
    }];
    
    [operation start];
}

-(void)fetchWeatherForecastForCity:(City *)city withCompletion:(CompletionBlock)completion andError:(ErrorBlock)errorBlock
{
    NSInteger pageNumber = 4*(1+mApplicationModel.pageCount);
    NSString *string = [[NSString stringWithFormat:@"%@%@?q=%@&mode=json&units=metric&cnt=%ld&APPID=%@", kBaseURL,kUrlCurrentForecast,city.cityName,(long)pageNumber,kOpenWeatherAPIKey] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        City * city = [CityWeatherBuilder buildForecastCityWeatherWithJSON:responseObject];
        mApplicationModel.currentCity = city;
        if(mApplicationModel.pageCount < 4)
            mApplicationModel.pageCount++;
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(responseObject);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            errorBlock(error);
        });
    }];
    
    [operation start];
}
@end
