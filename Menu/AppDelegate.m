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
#import "MManager.h"
#import "MSigninViewController.h"
#import "MCurrentLocationViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@import GoogleMaps;

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
    
    [GMSServices provideAPIKey:@"AIzaSyAyWnR6I_1znHoMbiNKIVtmWTjt4LVNRZ8"];
    
// DEVELOPMENT
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"D1157CB5F4084F1095F3BD12AA015104";
        configuration.server = @"http://menudevelopment.herokuapp.com/parse";
    }]];
    
//// LIVE
//    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
//        configuration.applicationId = @"0390D15E0418490C9143732983940773";
//        configuration.server = @"http://menulive.herokuapp.com/parse";
//    }]];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [FBSDKLoginButton class];
    
    if (![MManager isLocationSet]) {
        if (![MUser currentUser]) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MSigninViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MSigninViewController"];
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = rootViewController;
            [self.window makeKeyAndVisible];
        }
        else{
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MCurrentLocationViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"MCurrentLocationViewController"];
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            self.window.rootViewController = rootViewController;
            [self.window makeKeyAndVisible];
        }
    }
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

- (void)changeRootViewController:(UIViewController*)viewController {
    self.window.rootViewController = viewController;
}

@end
