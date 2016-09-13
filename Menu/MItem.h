//
//  MItem.h
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <Parse/Parse.h>
#import "MUser.h"
#import "MCuisine.h"
#import "MRestaurant.h"

@interface MItem : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSString *itemName;
@property (nonatomic, strong) NSString *itemCappedName;
@property (nonatomic, strong) NSNumber *itemPrice;
@property (nonatomic, strong) NSNumber *itemRating;
@property (nonatomic, strong) MCuisine *itemCuisine;
@property (nonatomic, strong) NSString *itemDescription;
@property (nonatomic, strong) MUser *itemUser;
@property (nonatomic, strong) PFGeoPoint *itemLocation;
@property (nonatomic, strong) NSString *itemCurrency;
@property (nonatomic, strong) NSString *itemCurrencySymbol;

@property (nonatomic, strong) NSString *itemDistance;
@property (nonatomic, strong) NSString *itemOpenHours;
@property (nonatomic, strong) NSNumber *itemOpen;

@property (nonatomic, strong) NSMutableArray *itemImageArray;
@property (nonatomic, strong) NSMutableArray *itemReviewArray;

@property (nonatomic, strong) MRestaurant *itemRestaurant;


@end
