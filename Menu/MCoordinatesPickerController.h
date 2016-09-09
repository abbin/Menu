//
//  MCoordinatesPickerController.h
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@import CoreLocation;

@interface MCoordinatesPickerController : UIViewController

-(void)withCompletionHandler:(void(^)(CLLocationCoordinate2D coordinates))handler;

@end
