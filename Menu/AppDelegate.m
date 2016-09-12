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
    
    [[UINavigationBar appearance] setBarTintColor:[MRemoteConfig mainColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:[MRemoteConfig primaryFontName] size:17.0]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setTranslucent:NO];
    
    [[UITextField appearance] setTintColor:[MRemoteConfig mainColor]];
    
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:[MRemoteConfig primaryFontName] size:10.0]} forState:UIControlStateNormal];
    [[UITabBar appearance] setTintColor:[MRemoteConfig mainColorSupliment]];
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UINavigationBar class]]] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:[MRemoteConfig primaryFontName] size:15.0]} forState:UIControlStateNormal];
    
    [GMSServices provideAPIKey:@"AIzaSyAyWnR6I_1znHoMbiNKIVtmWTjt4LVNRZ8"];
    
// DEVELOPMENT
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"C4F3184BCDCD4AFC842AD0DA372399F6";
        configuration.server = @"http://parseserver-3ix23-env.us-west-2.elasticbeanstalk.com/parse";
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
