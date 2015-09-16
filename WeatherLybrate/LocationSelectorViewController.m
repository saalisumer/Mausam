//
//  LocationSelectorViewController.m
//  WeatherLybrate
//
//  Created by SAALIS UMER on 12/09/15.
//  Copyright (c) 2015 SAALIS UMER. All rights reserved.
//

#import "LocationSelectorViewController.h"
#import "LocationCell.h"
#import "Constants.h"



@interface LocationSelectorViewController ()

@property (strong, nonatomic) CLGeocoder                    *geocoder;
@property (strong, nonatomic) NSMutableArray                *searchResults;
@property (strong, nonatomic) UISearchDisplayController     *searchController;
@property (strong, nonatomic) UISearchBar                   *searchBar;

@property (strong, nonatomic) UINavigationBar               *navigationBar;
@property (strong, nonatomic) UIBarButtonItem               *doneButton;

@end



@implementation LocationSelectorViewController

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

#pragma mark UIViewController Methods

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.view.backgroundColor = [UIColor clearColor];
    self.view.opaque = NO;
    
    self.geocoder = [[CLGeocoder alloc]init];
    self.searchResults = [[NSMutableArray alloc]initWithCapacity:5];
    
    self.navigationBar =[[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 64)];
    
    [self.view addSubview:self.navigationBar];
    
    self.doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                   target:self
                                                                   action:@selector(doneButtonPressed)];
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, 44)];
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.placeholder = kSearchPlaceholder;
    self.searchBar.delegate = self;
    
    self.searchController = [[UISearchDisplayController alloc]initWithSearchBar:self.searchBar contentsController:self];
    self.searchController.delegate = self;
    self.searchController.searchResultsDelegate = self;
    self.searchController.searchResultsDataSource = self;
    self.searchController.searchResultsTitle = kConstantAddLocation;
    self.searchController.displaysSearchBarInNavigationBar = YES;
    [self.searchController.searchResultsTableView registerClass:[LocationCell class] forCellReuseIdentifier:kLocationCellIdentifier];
    [self.searchController.searchResultsTableView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg"]]];
    self.searchController.navigationItem.rightBarButtonItems = @[self.doneButton];
    self.navigationBar.items = @[self.searchController.navigationItem];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [self.searchController setActive:YES animated:NO];
    [self.searchController.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.searchController setActive:NO animated:NO];
    [self.searchController.searchBar resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate dismissAddLocationViewController];
}

#pragma mark DoneButton Methods

- (void)doneButtonPressed
{
    if (self.searchBar.text.length == 0) {
        [self.delegate dismissAddLocationViewController];
    }
    else
    {
        [self.delegate didAddLocationWithText:self.searchBar.text];
        [self.delegate dismissAddLocationViewController];
    }
}

#pragma mark UISearchDisplayControllerDelegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{

    
    [self.geocoder geocodeAddressString:searchString
                      completionHandler: ^ (NSArray *placemarks, NSError *error) {
        self.searchResults = [[NSMutableArray alloc]initWithCapacity:1];
        for(CLPlacemark *placemark in placemarks) {
            if(placemark.locality) {
                [self.searchResults addObject:placemark];
            }
        }
        [controller.searchResultsTableView reloadData];
    }];
    return NO;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView
{
    [tableView setFrame:CGRectMake(0, CGRectGetHeight(self.navigationBar.bounds), CGRectGetWidth(self.view.bounds),
                                   CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.navigationBar.bounds))];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    [self.view bringSubviewToFront:self.navigationBar];
}

#pragma mark UITableViewDelegate Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationCell *cell = [tableView dequeueReusableCellWithIdentifier:kLocationCellIdentifier];
    if(tableView == self.searchController.searchResultsTableView) {
        CLPlacemark *placemark = [self.searchResults objectAtIndex:indexPath.row];
        cell.placemark = placemark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchController.searchResultsTableView) {
        [tableView cellForRowAtIndexPath:indexPath].selected = NO;
        CLPlacemark *placemark = [self.searchResults objectAtIndex:indexPath.row];
        [self.delegate didAddLocationWithPlacemark:placemark];
        [self.delegate dismissAddLocationViewController];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationBar.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y,
                                          CGRectGetWidth(self.navigationBar.frame),
                                          CGRectGetHeight(self.navigationBar.frame));
}

@end
