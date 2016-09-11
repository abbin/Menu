//
//  MSigninViewController.m
//  Menu
//
//  Created by Abbin Varghese on 11/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MSigninViewController.h"
#import "MRemoteConfig.h"

@interface MSigninViewController ()

@property (weak, nonatomic) IBOutlet UIButton *noThanksButton;

@end

@implementation MSigninViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noThanksButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:10.0];
}

@end
