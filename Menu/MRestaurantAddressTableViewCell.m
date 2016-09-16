//
//  MRestaurantAddressTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 16/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MRestaurantAddressTableViewCell.h"
#import "MRemoteConfig.h"

@interface MRestaurantAddressTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantLocationLabel;
@property (weak, nonatomic) IBOutlet UIButton *directionButton;

@end

@implementation MRestaurantAddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.restaurantNameLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.restaurantLocationLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    [self.directionButton.titleLabel setFont:[UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0]];
    [self.directionButton setTitleColor:[MRemoteConfig mainColor] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setRestaurant:(MRestaurant *)restaurant{
    self.restaurantNameLabel.text = restaurant.restaurantName;
    self.restaurantLocationLabel.text = restaurant.restaurantAddress;
}

@end
