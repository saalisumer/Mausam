//
//  ApplicationModel.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 13/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "Weather.h"

@interface ApplicationModel : NSObject
@property(nonatomic, strong) NSCache        * imageCache;
@property(nonatomic, strong) City           * currentCity;
@property(nonatomic, assign) NSInteger        pageCount;

+ (ApplicationModel *) sharedInstance;

- (void)clearModel;

@end
