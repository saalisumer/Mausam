//
//  LocationCell.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationCell : UITableViewCell
@property (nonatomic, assign) CLPlacemark * placemark;

@end
