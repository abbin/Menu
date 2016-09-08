//
//  MItemSearchTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 07/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MItemSearchTableViewCell.h"
#import "MRemoteConfig.h"

@implementation MItemSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
