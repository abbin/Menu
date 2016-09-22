//
//  MDetailImagesTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 13/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MDetailImagesTableViewCell.h"
#import "MDetailCollectionViewCell.h"

@implementation MDetailImagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MDetailCollectionViewCell" forIndexPath:indexPath];
    cell.imageDict = [self.images objectAtIndex:indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.height, collectionView.frame.size.height);
}
@end
