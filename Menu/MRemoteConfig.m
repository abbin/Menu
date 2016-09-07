//
//  MRemoteConfig.m
//  Menu
//
//  Created by Abbin Varghese on 07/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MRemoteConfig.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation MRemoteConfig

+(NSString*)primaryFontName{
    return @"Avenir-Black";
}

+(NSString*)secondaryFontName{
    return @"Avenir-Heavy";
}

+(UIColor*)secondaryColor{
    return UIColorFromRGB(0xC62828);
}

+(UIColor*)mainColor{
    return UIColorFromRGB(0xC62828);
}

@end
