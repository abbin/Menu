//
//  MCuisine.m
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MCuisine.h"
#import "PFObject+Subclass.h"
#import "MConstants.h"

@implementation MCuisine

@dynamic cuisineName;
@dynamic cuisineCappedName;

+(void)load{
    [self registerSubclass];
}

+(NSString *)parseClassName{
    return kMCuisineClassNameKey;
}

@end
