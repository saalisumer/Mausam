//
//  LocationSelectionViewController.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherViewController : UIViewController<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *lblTemperature;
@property (weak, nonatomic) IBOutlet UIImageView *imvWeather;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblWeatherDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblHumidity;
@property (weak, nonatomic) IBOutlet UILabel *lblWindDirection;
@property (weak, nonatomic) IBOutlet UILabel *lblTodayWeather;
@property (weak, nonatomic) IBOutlet UITableView *tblWeatherForecast;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadMore;
@property (weak, nonatomic) IBOutlet UIView *separator;
@property (weak, nonatomic) IBOutlet UIView *separator1;
- (IBAction)didTapLoadMore:(id)sender;
- (IBAction)didTapSelectLocation:(id)sender;

@end
