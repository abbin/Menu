//
//  MNearbyTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 10/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MNearbyTableViewCell.h"
#import "MConstants.h"
#import "UIImageView+AFNetworking.h"
#import "MRemoteConfig.h"
#import <HCSStarRatingView/HCSStarRatingView.h>
@interface MNearbyTableViewCell()

@property (weak, nonatomic) IBOutlet PFImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellItemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellItemRestaurantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellUserNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellDistanceButton;
@property (weak, nonatomic) IBOutlet HCSStarRatingView *cellRatingView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIView *userPhotoContainer;
@property (weak, nonatomic) IBOutlet UILabel *isOpenlabel;

@end

@implementation MNearbyTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.cellRatingView.tintColor = [MRemoteConfig ratingViewColor];
    self.cellItemNameLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:17.0];
    self.cellItemRestaurantNameLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.cellDistanceButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.cellUserNameLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.isOpenlabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    
    self.cellUserImageView.layer.cornerRadius = self.cellUserImageView.frame.size.height/2;
    self.cellUserImageView.layer.masksToBounds = YES;
    
    self.userPhotoContainer.layer.cornerRadius = self.userPhotoContainer.frame.size.height/2;
    self.userPhotoContainer.layer.masksToBounds = YES;
}

-(void)setCellItem:(MItem *)cellItem{
    PFFile *imageFile = [[cellItem.itemImageArray firstObject] objectForKey:kMItemImageFileKey];
    self.cellImageView.file = imageFile;
    [self.cellImageView loadInBackground];
    self.cellItemNameLabel.text = cellItem.itemName;
    self.cellItemRestaurantNameLabel.text = cellItem.itemRestaurant.restaurantName;
    self.cellUserNameLabel.text = cellItem.itemUser.displayName;
    self.cellRatingView.value = [cellItem.itemRating floatValue];
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:cellItem.itemUser.profilePhotoUrl]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [self.cellUserImageView setImageWithURLRequest:imageRequest
                              placeholderImage:[UIImage imageNamed:@"background"]
                                       success:nil
                                       failure:nil];
    if ([cellItem.itemOpen boolValue]) {
        self.isOpenlabel.text = @"Open now";
        self.isOpenlabel.textColor = [MRemoteConfig openGreen];
    }
    else{
        self.isOpenlabel.text = @"Closed now";
        self.isOpenlabel.textColor = [MRemoteConfig closedRed];
    }
    [self.cellDistanceButton setTitle:cellItem.itemDistance forState:UIControlStateNormal];
}

@end
