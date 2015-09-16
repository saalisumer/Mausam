//
//  LocationSelectionViewController.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "WeatherViewController.h"
#import "LocationSelectorViewController.h"
#import "ApplicationModel.h"
#import "WeatherCell.h"
#import "Constants.h"
#import "WeatherManager.h"
#import "MBProgressHUD.h"
#import "ImageDownloadManager.h"
#import "Reachability.h"

@interface WeatherViewController ()<LocationSelectorDelegate, ImageDownloadManagerDelegate>
{
    ApplicationModel                    * mApplicationModel;
    WeatherManager                      * mWeatherManager;
    MBProgressHUD                       * mHUD;
    ImageDownloadManager                * mImageDownloadManager;
}
@property (nonatomic, strong) LocationSelectorViewController * locationSelectorViewController;
@end

@implementation WeatherViewController

-(LocationSelectorViewController*)locationSelectorViewController
{
    if (_locationSelectorViewController == nil)
    {
        _locationSelectorViewController = [[LocationSelectorViewController alloc]init];
        _locationSelectorViewController.delegate = self;
    }
    return _locationSelectorViewController;
}

- (IBAction)didTapSelectLocation:(id)sender
{
        Reachability *reach = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus =  [reach currentReachabilityStatus];
        
        if(networkStatus == NotReachable) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"The Internet connection appears to be offline." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
            [alert show];
        } else {
    [self presentViewController:self.locationSelectorViewController animated:YES completion:^{
        
    }];
        }
}

- (IBAction)didTapLoadMore:(id)sender {
    
    if (mApplicationModel.pageCount == 4) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Forecast available for next 16 days only." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        [alert show];
        return;
    }
    
    [mHUD show:YES];
    [mWeatherManager fetchWeatherForecastForCity:mApplicationModel.currentCity withCompletion:^(id object) {
        [self refresh];
        [mHUD hide:YES];
    } andError:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        [alert show];
        [mHUD hide:YES];
    }];
}


- (void)viewDidLoad {
    mApplicationModel = [ApplicationModel sharedInstance];
    mWeatherManager = [WeatherManager sharedManager];
    mImageDownloadManager = [ImageDownloadManager instance];
    
    mHUD = [[MBProgressHUD alloc]initWithView:self.view ];
    [self.view addSubview:mHUD];
    [mHUD hide:NO];
    
    [self validateVisibility];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)validateVisibility
{
    if (mApplicationModel.currentCity == nil) {
        self.lblTemperature.hidden = self.imvWeather.hidden = self.lblLocation.hidden = self.lblWeatherDescription.hidden = self.lblHumidity.hidden = self.lblWindDirection.hidden = self.lblTodayWeather.hidden = self.tblWeatherForecast.hidden =  self.separator.hidden = self.separator1.hidden = self.btnLoadMore.hidden = YES;
    }
    else
    {
        self.lblTemperature.hidden = self.imvWeather.hidden = self.lblLocation.hidden = self.lblWeatherDescription.hidden = self.lblHumidity.hidden = self.lblWindDirection.hidden = self.lblTodayWeather.hidden = self.tblWeatherForecast.hidden =  self.separator.hidden = self.separator1.hidden = self.btnLoadMore.hidden = NO;
    }
}

- (void)validateProperties
{
    Weather * currentWeather = mApplicationModel.currentCity.currentWeather;
    self.lblTemperature.text = [NSString stringWithFormat:@"%@\u00B0 C", currentWeather.temperature];
    self.lblLocation.text = [NSString stringWithFormat:@"City: %@", mApplicationModel.currentCity.cityName];
    self.lblWeatherDescription.text = [NSString stringWithFormat:@"Weather: %@",currentWeather.weatherDesciption];
    self.lblHumidity.text = [NSString stringWithFormat:@"Humidity: %@ %%", currentWeather.humidity];
    self.lblWindDirection.text = [NSString stringWithFormat:@"Wind: %@",currentWeather.windDirection];
    
    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@.png",kImageBaseURL,mApplicationModel.currentCity.currentWeather.iconId]];
    self.imvWeather.image = [mImageDownloadManager loadImageForURL:imageURL imageId:mApplicationModel.currentCity.currentWeather.iconId delegate:self];
}

- (void)refresh
{
    [self validateVisibility];
    [self validateProperties];
    [self.tblWeatherForecast reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark LocationSelectorDelegate
- (void)didAddLocationWithPlacemark:(CLPlacemark *)placemark
{
    [mHUD show:YES];
    [mWeatherManager updateCurrentWeatherForPlacemark:placemark withCompletion:^(id object) {
        [self refresh];
        [mHUD hide:YES];
    } andError:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        [alert show];
        [mHUD hide:YES];
    }];
}

- (void)didAddLocationWithText:(NSString *)place
{
    [mHUD show:YES];
    [mWeatherManager updateCurrentWeatherForPlace:place withCompletion:^(id object) {
        [self refresh];
        [mHUD hide:YES];
    } andError:^(NSError *error) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil ];
        [alert show];
        [mHUD hide:YES];
    }];
}

- (void)dismissAddLocationViewController
{
    [self.locationSelectorViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return mApplicationModel.currentCity.forecast.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WeatherCell * cell = [tableView dequeueReusableCellWithIdentifier:kWeatherCellIdentifier forIndexPath:indexPath];
    Weather * weather = (Weather*)mApplicationModel.currentCity.forecast[indexPath.section];
    cell.weather = weather;
    NSURL * imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@.png",kImageBaseURL,weather.iconId]];
    cell.imvWeather.image = [mImageDownloadManager loadImageForURL:imageURL imageId:weather.iconId delegate:self];
    return cell;
}


#pragma mark ImageDownloadManager delegate
- (void)loadImageForURL:(NSURL *)url imageId:(NSString *)imageId
            didComplete:(UIImage *)image
{
    [self refresh];
}

- (void)loadImageForURL:(NSURL *)url imageId:(NSString *)imageId
       didFailWithError:(NSError *)error
{
    
}
@end
