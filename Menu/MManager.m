//
//  MManager.m
//  Menu
//
//  Created by Abbin Varghese on 10/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MManager.h"
#import "MConstants.h"

@implementation MManager

+(void)saveItem:(MItem*)item andRestaurant:(MRestaurant*)restaurant withImages:(NSArray*)images{
    
    NSNumber *timeStamp = [NSNumber numberWithDouble:[NSDate timeIntervalSinceReferenceDate]];
    NSMutableArray *imageArray = [NSMutableArray new];
    for (UIImage *image in images) {
        NSDictionary *dict = @{kMItemImageFileKey:[PFFile fileWithName:@"name.jpeg" data:UIImageJPEGRepresentation(image, 0.5)],
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

@end
