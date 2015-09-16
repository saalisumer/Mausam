//
//  WeatherCell.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 13/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weather.h"

@interface WeatherCell : UITableViewCell
@property (weak, nonatomic) Weather * weather;

@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UIImageView *imvWeather;
@property (weak, nonatomic) IBOutlet UILabel *lblMaxTemperature;
@property (weak, nonatomic) IBOutlet UILabel *lblMinTemperature;

@end
