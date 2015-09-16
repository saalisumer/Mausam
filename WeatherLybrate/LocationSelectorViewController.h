//
//  LocationSelectorViewController.h
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationSelectorDelegate <NSObject>
- (void)didAddLocationWithPlacemark:(CLPlacemark *)placemark;
- (void)dismissAddLocationViewController;
- (void)didAddLocationWithText:(NSString *)place;

@end

@interface LocationSelectorViewController : UIViewController <UISearchDisplayDelegate, UITableViewDelegate,
                                                                UITableViewDataSource, UISearchBarDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) id<LocationSelectorDelegate> delegate;

@end
