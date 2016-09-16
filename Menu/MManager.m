//
//  MManager.m
//  Menu
//
//  Created by Abbin Varghese on 10/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MManager.h"
#import "MConstants.h"
#import "NSMutableDictionary+MLocation.h"
#import "MReview.h"

@implementation MManager

+(NSMutableArray*)addArrayP:(NSArray*)newArray toOldArray:(NSMutableArray*)oldArray{
    NSSortDescriptor *voteDescriptor = [NSSortDescriptor sortDescriptorWithKey:kMItemImageVoteKey ascending:NO];
    NSSortDescriptor *dateDescriptor = [NSSortDescriptor sortDescriptorWithKey:kMItemImageTimeStampKey ascending:NO];
    
    NSMutableArray *finalArray = [NSMutableArray new];
    NSMutableArray *existingArray = oldArray;
    
    [existingArray sortUsingDescriptors:@[voteDescriptor,dateDescriptor]];
    [finalArray addObjectsFromArray:[existingArray subarrayWithRange:NSMakeRange(0, MIN(5,existingArray.count))]];
    
    [existingArray removeObjectsInRange:NSMakeRange(0, MIN(5,existingArray.count))];
    [existingArray addObjectsFromArray:newArray];
    [existingArray sortUsingDescriptors:@[dateDescriptor]];
    [finalArray addObjectsFromArray:existingArray];
    
    NSArray *result = [finalArray subarrayWithRange:NSMakeRange(0, MIN(10, finalArray.count))];
    [finalArray removeObjectsInRange:NSMakeRange(0, MIN(10, finalArray.count))];
    //    for (NSDictionary *dict in finalArray) {
    //        FIRStorageReference *storageRefdel = [[FIRStorage storage] referenceForURL:[NSString stringWithFormat:@"%@%@",kFAStoragePathKey,[dict objectForKey:kFAItemImagesPathKey]]];
    //        // Delete the file
    //        [storageRefdel deleteWithCompletion:^(NSError *error){
    //            if (error) {
    //                [FAAnalyticsManager logEventWithName:kFAAnalyticsFailureKey
    //                                          parameters:@{kFAAnalyticsReasonKey:error.localizedDescription,
    //                                                       kFAAnalyticsSectionKey:kFAAnalyticsStorageDeleteTaskKey}];
    //            }
    //        }];
    //    }
    return [result mutableCopy];
}

+(void)saveReview:(NSString*)review rating:(float)rating forItem:(MItem*)item withImages:(NSArray*)images{
    
    NSNumber *timeStamp = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
    NSMutableArray *imageArray = [NSMutableArray new];
    for (UIImage *image in images) {
        NSLog(@"File size is : %.2f MB",(float)UIImageJPEGRepresentation(image, 0.5).length/1024.0f/1024.0f);
        NSDictionary *dict = @{kMItemImageFileKey:[PFFile fileWithName:@"name.jpeg" data:UIImageJPEGRepresentation(image, 0.5)],
                               kMItemImageTimeStampKey:timeStamp,
                               kMItemImageVoteKey:[NSNumber numberWithUnsignedLong:0]};
        [imageArray addObject:dict];
    }
    item.itemImageArray = [self addArrayP:imageArray toOldArray:item.itemImageArray];
    NSMutableArray *reviewArray = item.itemReviewArray;
    if (reviewArray == nil) {
        reviewArray = [NSMutableArray new];
    }
    
    MReview *reviewObject = [MReview object];
    reviewObject.reviewText = review;
    reviewObject.ratingUser = [MUser currentUser];
    reviewObject.reviewRating = [NSNumber numberWithFloat:rating];
    reviewObject.reviewTimeStamp = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
    
    [reviewArray addObject:reviewObject];
    
    item.itemReviewArray = reviewArray;
    
    if (item.itemRating) {
        float oldRting = [item.itemRating floatValue];
        float newRating = (oldRting + rating)/2;
        item.itemRating = [NSNumber numberWithFloat:newRating];
    }
    else{
        item.itemRating = [NSNumber numberWithFloat:rating];
    }
    [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kMSaveFailNotificationKey object:self];
        }
        else{
            NSDictionary *object = [NSDictionary dictionaryWithObjectsAndKeys:item,@"object", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kMSaveCompleteNotificationKey object:self userInfo:object];
        }
    }];
}


+(void)saveItem:(MItem*)item andRestaurant:(MRestaurant*)restaurant withImages:(NSArray*)images{
    
    NSNumber *timeStamp = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
    NSMutableArray *imageArray = [NSMutableArray new];
    for (UIImage *image in images) {
        NSDictionary *dict = @{kMItemImageFileKey:[PFFile fileWithName:@"name.jpeg" data:UIImageJPEGRepresentation(image, 0.1)],
                               kMItemImageTimeStampKey:timeStamp,
                               kMItemImageVoteKey:[NSNumber numberWithUnsignedLong:0]};
        [imageArray addObject:dict];
    }
    item.itemRestaurant = restaurant;
    item.itemImageArray = imageArray;
    item.itemLocation = restaurant.restaurantLocation;
    
    [item saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kMSaveFailNotificationKey object:self];
        }
        else{
            NSDictionary *object = [NSDictionary dictionaryWithObjectsAndKeys:item,@"object", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:kMSaveCompleteNotificationKey object:self userInfo:object];
        }
    }];
}

+(BOOL)isLocationSet{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kMCurrentLocationKey]) {
        return YES;
    }
    else{
        return NO;
    }
}

+(NSString*)distanceFromLat:(double)lat lon:(double)lng{
    NSMutableDictionary *loc = [[NSUserDefaults standardUserDefaults] objectForKey:kMCurrentLocationKey];
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:[loc.locationLatitude doubleValue] longitude:[loc.locationLongitude doubleValue]];
    CLLocationDistance distance = [startLocation distanceFromLocation:endLocation];
    if (distance>1000) {
        NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
        [formatter setMaximumFractionDigits:0];
        return [NSString stringWithFormat:@"%@ km",[formatter stringFromNumber:[NSNumber numberWithDouble:distance/1000]]];
    }
    else{
        NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
        [formatter setMaximumFractionDigits:0];
        return [NSString stringWithFormat:@"%@ m",[formatter stringFromNumber:[NSNumber numberWithDouble:distance]]];
    }
}

+ (NSInteger)dictTimeToSeconds:(id)dictTime{
    NSInteger time = [dictTime integerValue];
    NSInteger hours = time / 100;
    NSInteger minutes = time % 100;
    return (hours * 60 * 60) + (minutes * 60);
}

+(void)modifyObject:(NSArray*)itemsArray{
    for (MItem *item in itemsArray) {
        double lat = item.itemLocation.latitude;
        double lng = item.itemLocation.longitude;
        item.itemDistance = [self distanceFromLat:lat lon:lng];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"EEEE"];
        NSString *dayName = [dateFormatter stringFromDate:[NSDate date]];
        
        NSString *predicateString = [NSString stringWithFormat:@"close.dayName like '%@'",dayName];
        NSPredicate *pred = [NSPredicate predicateWithFormat:predicateString];
        NSArray *result = [item.itemRestaurant.restaurantWorkingHours filteredArrayUsingPredicate:pred];
        NSMutableDictionary *todayDict = [result firstObject];
        
        NSString *closeString = [[todayDict objectForKey:@"close"] objectForKey:@"time"];
        NSString *openString = [[todayDict objectForKey:@"open"] objectForKey:@"time"];
        
        [dateFormatter setDateFormat:@"HHmm"];
        NSString *nowString = [dateFormatter stringFromDate:[NSDate date]];
        
        NSDate *openDate = [dateFormatter dateFromString:openString];
        NSDate *closeDate = [dateFormatter dateFromString:closeString];
        
        [dateFormatter setDateFormat:@"h:mm a"];
        
        NSString *openingHour = [dateFormatter stringFromDate:openDate];
        NSString *closingHour = [dateFormatter stringFromDate:closeDate];
        
        NSInteger nowSecond = [self dictTimeToSeconds:nowString];
        NSInteger closeSecond = [self dictTimeToSeconds:closeString];
        NSInteger openSecond = [self dictTimeToSeconds:openString];
        
        if (openSecond-closeSecond<0){
            if (nowSecond>openSecond && nowSecond<closeSecond){
                item.itemOpenHours = [NSString stringWithFormat:@"Open Now  from:%@ till:%@",openingHour,closingHour];
                item.itemOpen = @YES;
            }
            else{
                item.itemOpenHours = [NSString stringWithFormat:@"Closed Now  Open from:%@ till:%@",openingHour,closingHour];
                item.itemOpen = @NO;
            }
        }
        else{
            NSInteger midnightSecond = 23*60*60 + 59*60 + 59;
            if (nowSecond>openSecond && nowSecond < midnightSecond) {
                item.itemOpenHours = [NSString stringWithFormat:@"Open Now  from:%@ till:%@",openingHour,closingHour];
                item.itemOpen = @YES;
            }
            else if (nowSecond >= 0 && nowSecond <closeSecond){
                item.itemOpenHours = [NSString stringWithFormat:@"Open Now  from:%@ till:%@",openingHour,closingHour];
                item.itemOpen = @YES;
            }
            else{
                item.itemOpenHours = [NSString stringWithFormat:@"Closed Now  Open from:%@ till:%@",openingHour,closingHour];
                item.itemOpen = @NO;
            }
        }
    }
}

@end
