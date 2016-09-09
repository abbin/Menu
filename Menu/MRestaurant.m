//
//  MRestaurant.m
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MRestaurant.h"
#import "MConstants.h"
#import <Parse/PFObject+Subclass.h>

@implementation MRestaurant

@dynamic restaurantName;
@dynamic restaurantAddress;
@dynamic restaurantLocation;
@dynamic restaurantPhoneNumbers;
@dynamic restaurantWorkingHours;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return kMRestaurantClassNameKey;
}

@end
