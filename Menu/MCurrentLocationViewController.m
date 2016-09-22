//
//  MCurrentLocationViewController.m
//  Menu
//
//  Created by Abbin Varghese on 11/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MCurrentLocationViewController.h"
#import "MRemoteConfig.h"
#import "NSMutableDictionary+MLocation.h"
#import "MConstants.h"
#import "MLocationPickerController.h"
#import "AppDelegate.h"
#import "MTabBarController.h"

@import CoreLocation;

@interface MCurrentLocationViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *manualButton;
@property (weak, nonatomic) IBOutlet UIButton *autoDetectButton;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL firstUpdate;
@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation MCurrentLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.geocoder = [[CLGeocoder alloc] init];
    
    NSDictionary * linkAttributes = @{NSFontAttributeName:[UIFont fontWithName:[MRemoteConfig primaryFontName] size:10],
                                      NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.manualButton.titleLabel.text attributes:linkAttributes];
    [self.manualButton.titleLabel setAttributedText:attributedString];
    [self.autoDetectButton.titleLabel setFont:[UIFont fontWithName:[MRemoteConfig primaryFontName] size:15]];
    [self.autoDetectButton setBackgroundColor:[MRemoteConfig mainColor]];
}

- (IBAction)autoDetect:(id)sender {
    self.view.userInteractionEnabled = NO;
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }

    [self.locationManager requestWhenInUseAuthorization];

    [self.locationManager startUpdatingLocation];
}

- (IBAction)setManually:(id)sender {
    UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MLocationPickerController"];
    MLocationPickerController *vc = nav.viewControllers[0];
    [vc withCompletionHandler:^(NSMutableDictionary *location) {
        [[NSUserDefaults standardUserDefaults] setObject:location forKey:kMCurrentLocationKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        MTabBarController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTabBarController"];
        AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [delegate changeRootViewController:vc];
    }];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.view.userInteractionEnabled = YES;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (!self.firstUpdate) {
        [self.locationManager stopUpdatingLocation];
        CLLocation *currentLocation = locations[0];
        self.firstUpdate = YES;
        [self.geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            self.view.userInteractionEnabled = YES;
            if (error == nil && [placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks lastObject];
                NSDictionary *placemarkDict = placemark.addressDictionary;
                NSMutableDictionary *loc = [NSMutableDictionary new];
                loc.locationShortName = [placemarkDict objectForKey:@"City"];
                loc.locationLatitude = [NSNumber numberWithDouble:currentLocation.coordinate.latitude];
                loc.locationLongitude = [NSNumber numberWithDouble:currentLocation.coordinate.longitude];
                NSArray * wordArray = [placemarkDict objectForKey:@"FormattedAddressLines"];
                NSString* nospacestring = [wordArray componentsJoinedByString:@", "];
                loc.locationFullName = nospacestring;
                
                [[NSUserDefaults standardUserDefaults] setObject:loc forKey:kMCurrentLocationKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                MTabBarController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTabBarController"];
                AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                [delegate changeRootViewController:vc];
            }
        } ];
    }
}

@end
