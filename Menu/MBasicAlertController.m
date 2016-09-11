//
//  MBasicAlertController.m
//  Menu
//
//  Created by Abbin Varghese on 10/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MBasicAlertController.h"
#import "MRemoteConfig.h"

@interface MBasicAlertController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailedLabel;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (nonatomic, strong) void(^completionHandler)();

@end

@implementation MBasicAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
    self.titleLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:30.0];
    self.detailedLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.okButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    [self.okButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.titleLabel.text = self.titleString;
    self.detailedLabel.text = self.messageString;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 1;
    } completion:nil];
}

-(void)withCompletionHandler:(void(^)())handler{
    _completionHandler = handler;
}

- (IBAction)ok:(id)sender {
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:^{
            _completionHandler();
        }];
    }];
}

@end
