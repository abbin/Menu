//
//  MImageViewCollectionViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 16/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MImageViewCollectionViewCell.h"
#import <ParseUI/ParseUI.h>
#import "MConstants.h"

@interface MImageViewCollectionViewCell ()

@property (weak, nonatomic) IBOutlet PFImageView *cellImageView;

@end

@implementation MImageViewCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setImageDictionary:(NSDictionary *)imageDictionary{
    self.cellImageView.file = [imageDictionary objectForKey:kMItemImageFileKey];
    [self.cellImageView loadInBackground];
}

-(void)setCellImage:(UIImage *)cellImage{
    self.cellImageView.image = cellImage;
}

@end
