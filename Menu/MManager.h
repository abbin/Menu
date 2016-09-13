//
//  MManager.h
//  Menu
//
//  Created by Abbin Varghese on 10/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MItem.h"
#import "MRestaurant.h"

@interface MManager : NSObject

+(void)saveItem:(MItem*)item andRestaurant:(MRestaurant*)restaurant withImages:(NSArray*)images;

+(BOOL)isLocationSet;

+(void)modifyObject:(NSArray*)itemsArray;

@end
