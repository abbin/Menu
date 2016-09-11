//
//  MCuisine.h
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <Parse/Parse.h>

@interface MCuisine : PFObject<PFSubclassing>

+ (NSString *)parseClassName;

@property (nonatomic,strong) NSString *cuisineName;
@property (nonatomic,strong) NSString *cuisineCappedName;

@end
