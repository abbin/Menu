//
//  MRemoteConfig.m
//  Menu
//
//  Created by Abbin Varghese on 07/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MRemoteConfig.h"

#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation MRemoteConfig

+(NSString*)primaryFontName{
    return @"Avenir-Black";
}

+(NSString*)secondaryFontName{
    return @"Avenir-Heavy";
}

+(UIColor *)mainColorSupliment{
    return UIColorFromRGB(0xe16060);
}

+(UIColor *)ratingViewColor{
    return UIColorFromRGB(0xD4AF37);
}

+(UIColor *)mainColor{
    return UIColorFromRGB(0xD02935);
}
//D93535

+(UIColor *)closedRed{
    return UIColorFromRGB(0xbf0000);
}

+(UIColor *)openGreen{
    return UIColorFromRGB(0x00bf00);
}

@end
