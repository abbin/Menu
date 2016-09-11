//
//  MSigninViewController.m
//  Menu
//
//  Created by Abbin Varghese on 11/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MSigninViewController.h"
#import "MRemoteConfig.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "MUser.h"
#import "MManager.h"
#import "MCurrentLocationViewController.h"
#import "AppDelegate.h"
#import "MTabBarController.h"
#import <AVFoundation/AVFoundation.h>

@interface MSigninViewController ()<FBSDKLoginButtonDelegate>

@property (weak, nonatomic) IBOutlet UIButton *noThanksButton;

@property (weak, nonatomic) IBOutlet FBSDKLoginButton *facebookLoginButton;

@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (nonatomic, strong) AVPlayer *avplayer;
@end

@implementation MSigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * linkAttributes = @{NSFontAttributeName:[UIFont fontWithName:[MRemoteConfig primaryFontName] size:10],
                                      NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)};
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.noThanksButton.titleLabel.text attributes:linkAttributes];
    [self.noThanksButton.titleLabel setAttributedText:attributedString];
    
    self.facebookLoginButton.delegate = self;
    self.facebookLoginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    //Set up player
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMG_0102" ofType:@"mp4"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.avplayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avplayer];
    [avPlayerLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [avPlayerLayer setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*9/16)];
    [self.playerView.layer addSublayer:avPlayerLayer];
    
    //Config player
    [self.avplayer seekToTime:kCMTimeZero];
    [self.avplayer setVolume:0.0f];
    [self.avplayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avplayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.avplayer pause];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.avplayer play];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)playerStartPlaying
{
    [self.avplayer play];
}


- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error {
    if (error == nil && [FBSDKAccessToken currentAccessToken].tokenString) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{ @"fields" : @"id,first_name,last_name,email,picture.width(100).height(100)"}]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                if ([result objectForKey:@"email"]) {
                    MUser *user = [MUser user];
                    user.password = @"password";
                    user.email = [result objectForKey:@"email"];
                    user.username = [result objectForKey:@"email"];
                    user.displayName = [NSString stringWithFormat:@"%@ %@",[result objectForKey:@"first_name"],[result objectForKey:@"last_name"]];
                    NSString *url = [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"];
                    user.profilePhotoUrl = url;
                    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                        if (!error) {
                            if (![MManager isLocationSet]) {
                                MCurrentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MCurrentLocationViewController"];
                                [self.navigationController pushViewController:vc animated:YES];
                            }
                            else{
                                MTabBarController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTabBarController"];
                                AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                                [delegate changeRootViewController:vc];
                            }
                        }else{
                            if (error.code == 202 || error.code == 203) {
                                [PFUser logInWithUsernameInBackground:[result objectForKey:@"email"] password:@"password"
                                                                block:^(PFUser *user, NSError *error) {
                                                                    if (user && error == nil) {
                                                                        if (![MManager isLocationSet]) {
                                                                            MCurrentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MCurrentLocationViewController"];
                                                                            [self.navigationController pushViewController:vc animated:YES];
                                                                        }
                                                                        else{
                                                                            MTabBarController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTabBarController"];
                                                                            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                                                                            [delegate changeRootViewController:vc];
                                                                        }
                                                                    }
                                                                }];
                            }
                        }
                    }];
                    
                }
            }
        }];
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    
}

- (IBAction)noThanks:(id)sender {
    if (![MManager isLocationSet]) {
        MCurrentLocationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MCurrentLocationViewController"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        MTabBarController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTabBarController"];
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [delegate changeRootViewController:vc];
    }
}

@end
