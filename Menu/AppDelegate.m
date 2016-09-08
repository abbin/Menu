//
//  AppDelegate.m
//  Menu
//
//  Created by Abbin Varghese on 07/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "AppDelegate.h"
#import "MRemoteConfig.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:[MRemoteConfig primaryFontName] size:17.0]}];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    [[UITextField appearance] setTintColor:[UIColor redColor]];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:[MRemoteConfig primaryFontName] size:10.0]} forState:UIControlStateNormal];
    [[UITabBar appearance] setTintColor:[UIColor colorWithWhite:0.3 alpha:1]];
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:[MRemoteConfig primaryFontName] size:15.0]} forState:UIControlStateNormal];
    
// DEVELOPMENT
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"D1157CB5F4084F1095F3BD12AA015104";
        configuration.server = @"http://menudevelopment.herokuapp.com/parse";
    }]];
    
// LIVE
//    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
//        configuration.applicationId = @"0390D15E0418490C9143732983940773";
//        configuration.server = @"http://menulive.herokuapp.com/parse";
//    }]];
    
    return YES;
}

@end
