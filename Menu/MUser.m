//
//  MUser.m
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MUser.h"
#import <Parse/PFObject+Subclass.h>

@implementation MUser

@dynamic profilePhotoUrl;

+ (void)load {
    [self registerSubclass];
}

@end
