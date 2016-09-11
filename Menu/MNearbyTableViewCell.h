//
//  MNearbyTableViewCell.h
//  Menu
//
//  Created by Abbin Varghese on 10/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import "MItem.h"

@interface MNearbyTableViewCell : PFTableViewCell

@property (nonatomic, strong) MItem *cellItem;

@end
