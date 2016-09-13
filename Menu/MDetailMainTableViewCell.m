//
//  MDetailMainTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 13/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MDetailMainTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "MRemoteConfig.h"

@interface MDetailMainTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLocation;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIView *userImageContainer;

@end

@implementation MDetailMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userImageView.layer.cornerRadius = self.userImageView.frame.size.height/2;
    self.userImageView.layer.masksToBounds = YES;
    self.userImageContainer.layer.cornerRadius = self.userImageContainer.frame.size.height/2;
    self.userImageContainer.layer.masksToBounds = YES;
    
    self.itemNameLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:20];
    self.restaurantNameLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15];
    self.restaurantLocation.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10];
    self.priceLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15];
    self.descriptionLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(MItem *)item{
    NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:item.itemUser.profilePhotoUrl]
                                                  cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                              timeoutInterval:60];
    
    [self.userImageView setImageWithURLRequest:imageRequest
                                  placeholderImage:[UIImage imageNamed:@"background"]
                                           success:nil
                                           failure:nil];
    self.userNameLabel.text = item.itemUser.displayName;
    self.itemNameLabel.text = item.itemName;
    self.restaurantNameLabel.text = item.itemRestaurant.restaurantName;
    self.restaurantLocation.text = item.itemRestaurant.restaurantAddress;
    self.priceLabel.text = [NSString stringWithFormat:@"%@ %@",item.itemCurrencySymbol,item.itemPrice];
    self.descriptionLabel.text = item.itemDescription;
}

@end
