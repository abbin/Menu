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

@interface MNearbyTableViewCell()

@property (weak, nonatomic) IBOutlet PFImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellItemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellItemRestaurantNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellUserImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellUserNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *cellDistanceButton;
@property (weak, nonatomic) IBOutlet UIButton *cellRatingButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation MNearbyTableViewCell

-(void)awakeFromNib{
    [super awakeFromNib];
    self.cellItemNameLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:15.0];
    self.cellItemRestaurantNameLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.cellDistanceButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.cellRatingButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
}

-(void)setCellItem:(MItem *)cellItem{
    PFFile *imageFile = [[cellItem.itemImageArray firstObject] objectForKey:kMItemImageFileKey];
    self.cellImageView.file = imageFile;
    [self.cellImageView loadInBackground];
    self.cellItemNameLabel.text = cellItem.itemName;
    self.cellItemRestaurantNameLabel.text = cellItem.itemRestaurant.restaurantName;
    self.cellUserNameLabel.text = cellItem.itemUser.displayName;
    
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:cellItem.itemUser.profilePhotoUrl]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [self.cellUserImageView setImageWithURLRequest:imageRequest
                              placeholderImage:[UIImage imageNamed:@"background"]
                                       success:nil
                                       failure:nil];
    
}

@end
