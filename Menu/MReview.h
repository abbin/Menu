//
//  MReview.h
//  Menu
//
//  Created by Abbin Varghese on 16/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <Parse/Parse.h>
#import "MUser.h"

@interface MReview : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic, strong) NSNumber *reviewTimeStamp;
@property (nonatomic, strong) NSString *reviewText;
@property (nonatomic, strong) NSNumber *reviewRating;
@property (nonatomic, strong) MUser *ratingUser;

@end
