//
//  MWorkingDaysPickerController.m
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MWorkingDaysPickerController.h"
#import "MRemoteConfig.h"
#import "UIView+Glow.h"

@interface MWorkingDaysPickerController ()
@property (weak, nonatomic) IBOutlet UIButton *mondayButton;
@property (weak, nonatomic) IBOutlet UIButton *tuesdayButton;
@property (weak, nonatomic) IBOutlet UIButton *wednesdayButton;
@property (weak, nonatomic) IBOutlet UIButton *thursdayButton;
@property (weak, nonatomic) IBOutlet UIButton *fridayButton;
@property (weak, nonatomic) IBOutlet UIButton *saturdayButton;
@property (weak, nonatomic) IBOutlet UIButton *sundayButton;

@property (weak, nonatomic) IBOutlet UIView *mondayGlowView;
@property (weak, nonatomic) IBOutlet UIView *tuesdayGlowView;
@property (weak, nonatomic) IBOutlet UIView *wednesdayGlowView;
@property (weak, nonatomic) IBOutlet UIView *thursdayGlowView;
@property (weak, nonatomic) IBOutlet UIView *fridayGlowView;
@property (weak, nonatomic) IBOutlet UIView *saturdayGlowView;
@property (weak, nonatomic) IBOutlet UIView *sundayGlowView;

@end

@implementation MWorkingDaysPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat borderWidth = 1;
    UIColor *color = [UIColor colorWithRed:1 green:0.5 blue:0.5 alpha:1];
    
    self.mondayGlowView.layer.cornerRadius = self.mondayGlowView.frame.size.height/2;
    self.mondayGlowView.layer.masksToBounds = YES;
    self.mondayGlowView.layer.borderWidth = borderWidth;
    self.mondayGlowView.layer.borderColor = color.CGColor;
    
    self.tuesdayGlowView.layer.cornerRadius = self.tuesdayGlowView.frame.size.height/2;
    self.tuesdayGlowView.layer.masksToBounds = YES;
    self.tuesdayGlowView.layer.borderWidth = borderWidth;
    self.tuesdayGlowView.layer.borderColor = color.CGColor;
    
    self.wednesdayGlowView.layer.cornerRadius = self.wednesdayGlowView.frame.size.height/2;
    self.wednesdayGlowView.layer.masksToBounds = YES;
    self.wednesdayGlowView.layer.borderWidth = borderWidth;
    self.wednesdayGlowView.layer.borderColor = color.CGColor;
    
    self.thursdayGlowView.layer.cornerRadius = self.thursdayGlowView.frame.size.height/2;
    self.thursdayGlowView.layer.masksToBounds = YES;
    self.thursdayGlowView.layer.borderWidth = borderWidth;
    self.thursdayGlowView.layer.borderColor = color.CGColor;
    
    self.fridayGlowView.layer.cornerRadius = self.fridayGlowView.frame.size.height/2;
    self.fridayGlowView.layer.masksToBounds = YES;
    self.fridayGlowView.layer.borderWidth = borderWidth;
    self.fridayGlowView.layer.borderColor = color.CGColor;
    
    self.saturdayGlowView.layer.cornerRadius = self.saturdayGlowView.frame.size.height/2;
    self.saturdayGlowView.layer.masksToBounds = YES;
    self.saturdayGlowView.layer.borderWidth = borderWidth;
    self.saturdayGlowView.layer.borderColor = color.CGColor;
    
    self.sundayGlowView.layer.cornerRadius = self.sundayGlowView.frame.size.height/2;
    self.sundayGlowView.layer.masksToBounds = YES;
    self.sundayGlowView.layer.borderWidth = borderWidth;
    self.sundayGlowView.layer.borderColor = color.CGColor;
    
    self.mondayButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.tuesdayButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.wednesdayButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.thursdayButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.fridayButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.saturdayButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.sundayButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
}

- (IBAction)selectMonday:(id)sender {
    if (self.mondayGlowView.glowView == nil) {
        [self.mondayGlowView startGlowing];
    }
    else{
        [self.mondayGlowView stopGlowing];
    }
}
- (IBAction)selectTuesday:(id)sender {
    if (self.tuesdayGlowView.glowView == nil) {
        [self.tuesdayGlowView startGlowing];
    }
    else{
        [self.tuesdayGlowView stopGlowing];
    }
}
- (IBAction)selectWednesday:(id)sender {
    if (self.wednesdayGlowView.glowView == nil) {
        [self.wednesdayGlowView startGlowing];
    }
    else{
        [self.wednesdayGlowView stopGlowing];
    }
}
- (IBAction)selectThrusday:(id)sender {
    if (self.thursdayGlowView.glowView == nil) {
        [self.thursdayGlowView startGlowing];
    }
    else{
        [self.thursdayGlowView stopGlowing];
    }
}
- (IBAction)selectFriday:(id)sender {
    if (self.fridayGlowView.glowView == nil) {
        [self.fridayGlowView startGlowing];
    }
    else{
        [self.fridayGlowView stopGlowing];
    }
}
- (IBAction)selectSaturday:(id)sender {
    if (self.saturdayGlowView.glowView == nil) {
        [self.saturdayGlowView startGlowing];
    }
    else{
        [self.saturdayGlowView stopGlowing];
    }
}
- (IBAction)selectSunday:(id)sender {
    if (self.sundayGlowView.glowView == nil) {
        [self.sundayGlowView startGlowing];
    }
    else{
        [self.sundayGlowView stopGlowing];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
