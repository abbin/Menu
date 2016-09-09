//
//  MCoordinatesPickerController.m
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MCoordinatesPickerController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MConstants.h"
#import "NSMutableDictionary+MLocation.h"

@interface MCoordinatesPickerController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation * currentLocation;
@property (nonatomic, assign) BOOL firstUpdate;

@property (nonatomic, strong) void(^completionHandler)(CLLocationCoordinate2D);

@end

@implementation MCoordinatesPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];

}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        _completionHandler(self.mapView.camera.target);
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)withCompletionHandler:(void(^)(CLLocationCoordinate2D coordinates))handler{
    _completionHandler = handler;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    if (!self.firstUpdate) {
        self.firstUpdate = YES;
        self.currentLocation = [locations firstObject];
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                                longitude:self.currentLocation.coordinate.longitude
                                                                     zoom:15];
        [self.mapView animateToCameraPosition:camera];
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse || status != kCLAuthorizationStatusAuthorizedAlways ) {
        NSMutableDictionary *loc = [[NSUserDefaults standardUserDefaults]objectForKey:kMCurrentLocationKey];
        
        double lat = [loc.locationLatitude doubleValue];
        double lng = [loc.locationLongitude doubleValue];
        
        self.currentLocation = [[CLLocation alloc]initWithLatitude:lat longitude:lng];
        
        [self.mapView setCamera:[GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lng
                                                                 zoom:15]];
    }
}
- (IBAction)gotocurrentLocation:(id)sender {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.currentLocation.coordinate.latitude
                                                            longitude:self.currentLocation.coordinate.longitude
                                                                 zoom:15];
    [self.mapView animateToCameraPosition:camera];
}

@end
