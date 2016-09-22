//
//  MWorkingHoursTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 17/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MWorkingHoursTableViewCell.h"
#import "MRemoteConfig.h"

@interface MWorkingHoursTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *mondayLabel;
@property (weak, nonatomic) IBOutlet UILabel *tuesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *wednesdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *thursdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *fridayLabel;
@property (weak, nonatomic) IBOutlet UILabel *saturdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *sundayLabel;

@end

@implementation MWorkingHoursTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.mondayLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    self.tuesdayLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    self.wednesdayLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    self.thursdayLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    self.fridayLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    self.saturdayLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    self.sundayLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    
    self.mondayLabel.text = @"";
    self.tuesdayLabel.text = @"";
    self.wednesdayLabel.text = @"";
    self.thursdayLabel.text = @"";
    self.fridayLabel.text = @"";
    self.saturdayLabel.text = @"";
    self.sundayLabel.text = @"";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setWorkingHours:(NSArray *)workingHours{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    for (NSDictionary *dayDict in workingHours) {
        NSInteger day = [[[dayDict objectForKey:@"close"] objectForKey:@"day"] integerValue];
        if (day == 0) {
            NSString *closeString = [[dayDict objectForKey:@"close"] objectForKey:@"time"];
            NSString *openString = [[dayDict objectForKey:@"open"] objectForKey:@"time"];
            NSString *dayName = [[dayDict objectForKey:@"open"] objectForKey:@"dayName"];
            
            [dateFormatter setDateFormat:@"HHmm"];
            
            NSDate *openDate = [dateFormatter dateFromString:openString];
            NSDate *closeDate = [dateFormatter dateFromString:closeString];
            
            [dateFormatter setDateFormat:@"h:mm a"];
            
            NSString *openingHour = [dateFormatter stringFromDate:openDate];
            NSString *closingHour = [dateFormatter stringFromDate:closeDate];
            
            self.sundayLabel.text =     [NSString stringWithFormat:@"Sunday     %@ till:%@",openingHour,closingHour];
            
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            
            if ([dayName isEqualToString:today]){
                self.sundayLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:12.0];
                self.sundayLabel.alpha = 0.8;
            }
        }
        else if (day == 1){
            NSString *closeString = [[dayDict objectForKey:@"close"] objectForKey:@"time"];
            NSString *openString = [[dayDict objectForKey:@"open"] objectForKey:@"time"];
            NSString *dayName = [[dayDict objectForKey:@"open"] objectForKey:@"dayName"];
            
            [dateFormatter setDateFormat:@"HHmm"];
            
            NSDate *openDate = [dateFormatter dateFromString:openString];
            NSDate *closeDate = [dateFormatter dateFromString:closeString];
            
            [dateFormatter setDateFormat:@"h:mm a"];
            
            NSString *openingHour = [dateFormatter stringFromDate:openDate];
            NSString *closingHour = [dateFormatter stringFromDate:closeDate];
            
            self.mondayLabel.text =     [NSString stringWithFormat:@"Monday     %@ till:%@",openingHour,closingHour];
            
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            
            if ([dayName isEqualToString:today]){
                self.mondayLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:12.0];
                self.mondayLabel.alpha = 0.8;
            }
        }
        else if (day == 2){
            NSString *closeString = [[dayDict objectForKey:@"close"] objectForKey:@"time"];
            NSString *openString = [[dayDict objectForKey:@"open"] objectForKey:@"time"];
            NSString *dayName = [[dayDict objectForKey:@"open"] objectForKey:@"dayName"];
            
            [dateFormatter setDateFormat:@"HHmm"];
            
            NSDate *openDate = [dateFormatter dateFromString:openString];
            NSDate *closeDate = [dateFormatter dateFromString:closeString];
            
            [dateFormatter setDateFormat:@"h:mm a"];
            
            NSString *openingHour = [dateFormatter stringFromDate:openDate];
            NSString *closingHour = [dateFormatter stringFromDate:closeDate];
            
            self.tuesdayLabel.text =    [NSString stringWithFormat:@"Tuesday    %@ till:%@",openingHour,closingHour];
            
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            
            if ([dayName isEqualToString:today]){
                self.tuesdayLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:12.0];
                self.tuesdayLabel.alpha = 0.8;
            }
        }
        else if (day == 3){
            NSString *closeString = [[dayDict objectForKey:@"close"] objectForKey:@"time"];
            NSString *openString = [[dayDict objectForKey:@"open"] objectForKey:@"time"];
            NSString *dayName = [[dayDict objectForKey:@"open"] objectForKey:@"dayName"];
            
            [dateFormatter setDateFormat:@"HHmm"];
            
            NSDate *openDate = [dateFormatter dateFromString:openString];
            NSDate *closeDate = [dateFormatter dateFromString:closeString];
            
            [dateFormatter setDateFormat:@"h:mm a"];
            
            NSString *openingHour = [dateFormatter stringFromDate:openDate];
            NSString *closingHour = [dateFormatter stringFromDate:closeDate];
            
            self.wednesdayLabel.text =  [NSString stringWithFormat:@"Wednesday  %@ till:%@",openingHour,closingHour];
            
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            
            if ([dayName isEqualToString:today]){
                self.wednesdayLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:12.0];
                self.wednesdayLabel.alpha = 0.8;
            }
        }
        else if (day == 4){
            NSString *closeString = [[dayDict objectForKey:@"close"] objectForKey:@"time"];
            NSString *openString = [[dayDict objectForKey:@"open"] objectForKey:@"time"];
            NSString *dayName = [[dayDict objectForKey:@"open"] objectForKey:@"dayName"];
            
            [dateFormatter setDateFormat:@"HHmm"];
            
            NSDate *openDate = [dateFormatter dateFromString:openString];
            NSDate *closeDate = [dateFormatter dateFromString:closeString];
            
            [dateFormatter setDateFormat:@"h:mm a"];
            
            NSString *openingHour = [dateFormatter stringFromDate:openDate];
            NSString *closingHour = [dateFormatter stringFromDate:closeDate];
            
            self.thursdayLabel.text =   [NSString stringWithFormat:@"Thursday   %@ till:%@",openingHour,closingHour];
            
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            
            if ([dayName isEqualToString:today]){
                self.thursdayLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:12.0];
                self.thursdayLabel.alpha = 0.8;
            }
        }
        else if (day == 5){
            NSString *closeString = [[dayDict objectForKey:@"close"] objectForKey:@"time"];
            NSString *openString = [[dayDict objectForKey:@"open"] objectForKey:@"time"];
            NSString *dayName = [[dayDict objectForKey:@"open"] objectForKey:@"dayName"];
            
            [dateFormatter setDateFormat:@"HHmm"];
            
            NSDate *openDate = [dateFormatter dateFromString:openString];
            NSDate *closeDate = [dateFormatter dateFromString:closeString];
            
            [dateFormatter setDateFormat:@"h:mm a"];
            
            NSString *openingHour = [dateFormatter stringFromDate:openDate];
            NSString *closingHour = [dateFormatter stringFromDate:closeDate];
            
            self.fridayLabel.text =     [NSString stringWithFormat:@"Friday     %@ till:%@",openingHour,closingHour];
            
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            
            if ([dayName isEqualToString:today]){
                self.fridayLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:12.0];
                self.fridayLabel.alpha = 0.8;
            }
        }
        else if (day == 6){
            NSString *closeString = [[dayDict objectForKey:@"close"] objectForKey:@"time"];
            NSString *openString = [[dayDict objectForKey:@"open"] objectForKey:@"time"];
            NSString *dayName = [[dayDict objectForKey:@"open"] objectForKey:@"dayName"];
            
            [dateFormatter setDateFormat:@"HHmm"];
            
            NSDate *openDate = [dateFormatter dateFromString:openString];
            NSDate *closeDate = [dateFormatter dateFromString:closeString];
            
            [dateFormatter setDateFormat:@"h:mm a"];
            
            NSString *openingHour = [dateFormatter stringFromDate:openDate];
            NSString *closingHour = [dateFormatter stringFromDate:closeDate];
            
            self.saturdayLabel.text =   [NSString stringWithFormat:@"Saturday   %@ till:%@",openingHour,closingHour];
            
            [dateFormatter setDateFormat:@"EEEE"];
            NSString *today = [dateFormatter stringFromDate:[NSDate date]];
            
            if ([dayName isEqualToString:today]){
                self.saturdayLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:12.0];
                self.saturdayLabel.alpha = 0.8;
            }
        }
    }
}

@end
