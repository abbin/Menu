//
//  MConstants.h
//  Menu
//
//  Created by Abbin Varghese on 07/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

@interface MConstants : NSObject

FOUNDATION_EXPORT NSString *const kMItemsClassNameKey;

FOUNDATION_EXPORT NSString *const kMItemsUserKey;
FOUNDATION_EXPORT NSString *const kMItemRestaurantKey;

FOUNDATION_EXPORT NSString *const kMCuisineClassNameKey;
FOUNDATION_EXPORT NSString *const kMRestaurantClassNameKey;

FOUNDATION_EXPORT NSString *const kMCuisineNameKey;

FOUNDATION_EXPORT NSString *const kMCurrentLocationKey;

FOUNDATION_EXPORT NSString *const kMGoogleServerKey;

FOUNDATION_EXPORT NSString *const kMItemCappedNameKey;

FOUNDATION_EXPORT NSString *const kMItemImageFileKey;
FOUNDATION_EXPORT NSString *const kMItemImageTimeStampKey;
FOUNDATION_EXPORT NSString *const kMItemImageVoteKey;

FOUNDATION_EXPORT NSString *const kMSaveCompleteNotificationKey;
FOUNDATION_EXPORT NSString *const kMSaveFailNotificationKey;

@end
