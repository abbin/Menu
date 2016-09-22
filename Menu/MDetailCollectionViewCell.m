//
//  MDetailCollectionViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 13/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MDetailCollectionViewCell.h"
#import <ParseUI/ParseUI.h>
#import "MConstants.h"

@interface MDetailCollectionViewCell ()

@property (weak, nonatomic) IBOutlet PFImageView *cellImageView;

@end

@implementation MDetailCollectionViewCell

-(void)setImageDict:(NSDictionary *)imageDict{
    self.cellImageView.file = [imageDict objectForKey:kMItemImageFileKey];
    [self.cellImageView loadInBackground];
}

@end
