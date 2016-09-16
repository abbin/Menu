//
//  MReviewTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 16/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MReviewTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface MReviewTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellUserNamewLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellUserDetailsLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellRatingButton;
@property (weak, nonatomic) IBOutlet UILabel *cellTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellReviewTextLabel;

@end

@implementation MReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setReview:(MReview *)review{
//    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:review.ratingUser.profilePhotoUrl]
//                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                              timeoutInterval:60];
//    [self.cellUserImageView setImageWithURLRequest:imageRequest
//                                  placeholderImage:[UIImage imageNamed:@"background"]
//                                           success:nil
//                                           failure:nil];
//    self.cellUserNamewLabel.text = review.ratingUser.displayName;
//    self.cellUserDetailsLabel.text = @"blah blah";
    
    NSTimeInterval theTimeInterval = [review.reviewTimeStamp doubleValue];
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:date1];
    NSCalendarUnit unitFlags = NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    if ([breakdownInfo month]>0){
        self.cellTimeLabel.text = [NSString stringWithFormat:@"%ld months ago",(long)[breakdownInfo month]];
    }
    else if ([breakdownInfo day]>0){
        self.cellTimeLabel.text = [NSString stringWithFormat:@"%ld days ago",(long)[breakdownInfo day]];
    }
    else if ([breakdownInfo hour]>0){
        self.cellTimeLabel.text = [NSString stringWithFormat:@"%ld hours ago",(long)[breakdownInfo hour]];
    }
    
    self.cellReviewTextLabel.text = review.reviewText;
}

@end
