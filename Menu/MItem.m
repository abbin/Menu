//
//  MItem.m
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MItem.h"
#import "PFObject+Subclass.h"
#import "MConstants.h"

@implementation MItem

@dynamic itemName;
@dynamic itemPrice;
@dynamic itemRating;
@dynamic itemUser;
@dynamic itemLocation;
@dynamic itemDescription;
@dynamic itemCurrency;
@dynamic itemCurrencySymbol;
@dynamic itemImageArray;
@dynamic itemReviewArray;
@dynamic itemRestaurant;
@dynamic itemCappedName;
@dynamic itemDistance;
@dynamic itemOpenHours;
@dynamic itemCuisine;
@dynamic itemOpen;

+(void)load{
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return kMItemsClassNameKey;
}

@end
