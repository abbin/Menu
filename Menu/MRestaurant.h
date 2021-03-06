//
//  MRestaurant.h
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <Parse/Parse.h>

@interface MRestaurant : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (strong, nonatomic) NSString *restaurantName;
@property (strong, nonatomic) NSString *restaurantAddress;
@property (strong, nonatomic) PFGeoPoint *restaurantLocation;
@property (strong, nonatomic) NSMutableArray *restaurantPhoneNumbers;
@property (strong, nonatomic) NSMutableArray *restaurantWorkingHours;

+(MRestaurant*)initWithName:(NSString*)name address:(NSString*)address coordinate:(CLLocationCoordinate2D)coordinate phonumber:(NSMutableArray*)phoneNumber workingDays:(NSMutableArray*)workingDays from:(NSString*)from till:(NSString*)till;

+(MRestaurant*)initWithDictionary:(NSDictionary*)dictionary;

@end
