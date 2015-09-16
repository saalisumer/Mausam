//
//  LocationCell.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "LocationCell.h"
#import "Constants.h"

@implementation LocationCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSString *)reuseIdentifier
{
    return kLocationCellIdentifier;
}

-(void)setPlacemark:(CLPlacemark *)placemark
{
    _placemark = placemark;
    [self validateProperties];
}

-(void)validateProperties
{
    self.backgroundColor = [UIColor clearColor];
    self.textLabel.textColor = [UIColor whiteColor];
    NSString *city = _placemark.locality;
    NSString *country = _placemark.country;
    NSString *cellText = [NSString stringWithFormat:@"%@, %@", city, country];
    if([[country lowercaseString] isEqualToString:@"india"]) {
        NSString *state = _placemark.administrativeArea;
        cellText = [NSString stringWithFormat:@"%@, %@, %@", city, state, country];
    }
    self.textLabel.text = cellText;
}

@end
