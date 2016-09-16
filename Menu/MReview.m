//
//  MReview.m
//  Menu
//
//  Created by Abbin Varghese on 16/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MReview.h"
#import "PFObject+Subclass.h"
#import "MConstants.h"

@implementation MReview

@dynamic reviewText;
@dynamic ratingUser;
@dynamic reviewRating;
@dynamic reviewTimeStamp;

+(void)load{
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return kMReviewClassNameKey;
}

@end
