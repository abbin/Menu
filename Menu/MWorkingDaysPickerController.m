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

@property (nonatomic, strong) void(^completionHandler)(NSMutableArray *);

@property (strong, nonatomic) NSMutableArray *daysArray;

@end

@implementation MWorkingDaysPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.daysArray = [[NSMutableArray alloc]init];
    
    CGFloat borderWidth = 1;
    UIColor *color = [MRemoteConfig mainColor];
    
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

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    for (NSDictionary *dict in self.workingDaysArray) {
        NSInteger day = [[[dict objectForKey:@"close"] objectForKey:@"day"] integerValue];
        switch (day) {
            case 0:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                [self.sundayGlowView startGlowing];
                break;
            case 1:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                [self.mondayGlowView startGlowing];
                break;
            case 2:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                [self.tuesdayGlowView startGlowing];
                break;
            case 3:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                [self.wednesdayGlowView startGlowing];
                break;
            case 4:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                [self.thursdayGlowView startGlowing];
                break;
            case 5:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                [self.fridayGlowView startGlowing];
                break;
            case 6:
                [self.daysArray addObject:[NSNumber numberWithInteger:day]];
                [self.saturdayGlowView startGlowing];
                break;
                
            default:
                break;
        }
    }
}

- (IBAction)selectMonday:(id)sender {
    if (self.mondayGlowView.glowView == nil) {
        [self.mondayGlowView startGlowing];
        [self.daysArray addObject:[NSNumber numberWithInteger:1]];
    }
    else{
        [self.mondayGlowView stopGlowing];
        [self.daysArray removeObject:[NSNumber numberWithInteger:1]];
    }
}
- (IBAction)selectTuesday:(id)sender {
    if (self.tuesdayGlowView.glowView == nil) {
        [self.tuesdayGlowView startGlowing];
        [self.daysArray addObject:[NSNumber numberWithInteger:2]];
    }
    else{
        [self.tuesdayGlowView stopGlowing];
        [self.daysArray removeObject:[NSNumber numberWithInteger:2]];
    }
}
- (IBAction)selectWednesday:(id)sender {
    if (self.wednesdayGlowView.glowView == nil) {
        [self.wednesdayGlowView startGlowing];
        [self.daysArray addObject:[NSNumber numberWithInteger:3]];
    }
    else{
        [self.wednesdayGlowView stopGlowing];
        [self.daysArray removeObject:[NSNumber numberWithInteger:3]];
    }
}
- (IBAction)selectThrusday:(id)sender {
    if (self.thursdayGlowView.glowView == nil) {
        [self.thursdayGlowView startGlowing];
        [self.daysArray addObject:[NSNumber numberWithInteger:4]];
    }
    else{
        [self.thursdayGlowView stopGlowing];
        [self.daysArray removeObject:[NSNumber numberWithInteger:4]];
    }
}
- (IBAction)selectFriday:(id)sender {
    if (self.fridayGlowView.glowView == nil) {
        [self.fridayGlowView startGlowing];
        [self.daysArray addObject:[NSNumber numberWithInteger:5]];
    }
    else{
        [self.fridayGlowView stopGlowing];
        [self.daysArray removeObject:[NSNumber numberWithInteger:5]];
    }
}
- (IBAction)selectSaturday:(id)sender {
    if (self.saturdayGlowView.glowView == nil) {
        [self.saturdayGlowView startGlowing];
        [self.daysArray addObject:[NSNumber numberWithInteger:6]];
    }
    else{
        [self.saturdayGlowView stopGlowing];
        [self.daysArray removeObject:[NSNumber numberWithInteger:6]];
    }
}
- (IBAction)selectSunday:(id)sender {
    if (self.sundayGlowView.glowView == nil) {
        [self.sundayGlowView startGlowing];
        [self.daysArray addObject:[NSNumber numberWithInteger:0]];
    }
    else{
        [self.sundayGlowView stopGlowing];
        [self.daysArray removeObject:[NSNumber numberWithInteger:0]];
    }
}

-(void)withCompletionHandler:(void(^)(NSMutableArray *days))handler{
    _completionHandler = handler;
}

- (IBAction)done:(id)sender {
    NSMutableArray *arrayOfDays = [NSMutableArray new];
    for (NSNumber *num in self.daysArray) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSArray *daySymbols = dateFormatter.standaloneWeekdaySymbols;
        
        NSInteger dayIndex = [num integerValue]; // 0 = Sunday, ... 6 = Saturday
        NSString *dayName = daySymbols[dayIndex];
        
        NSMutableDictionary *close = [NSMutableDictionary dictionaryWithObjectsAndKeys:num,@"day",dayName, @"dayName", nil];
        NSMutableDictionary *open = [NSMutableDictionary dictionaryWithObjectsAndKeys:num,@"day",dayName, @"dayName", nil];
        NSMutableDictionary *mainDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:close,@"close",open,@"open", nil];
        [arrayOfDays addObject:mainDict];
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        _completionHandler(arrayOfDays);
    }];
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
