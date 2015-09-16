//
//  WeatherCell.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 13/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "WeatherCell.h"
#import "Constants.h"

@implementation WeatherCell

-(NSString *)reuseIdentifier
{
    return kWeatherCellIdentifier;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setWeather:(Weather *)weather
{
    _weather = weather;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"dd/MM";
    self.lblDate.text = [NSString stringWithFormat:@"%@ - %@", [formatter stringFromDate:self.weather.date],self.weather.weatherDesciption];
    
    self.lblMaxTemperature.text = [NSString stringWithFormat:@"Max: %@\u00B0 C",self.weather.temperatureMax];
    self.lblMinTemperature.text = [NSString stringWithFormat:@"Min: %@\u00B0 C",self.weather.temperatureMin];
}

@end
