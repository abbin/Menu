//
//  MDetailImagesTableViewCell.m
//  Menu
//
//  Created by Abbin Varghese on 13/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MDetailImagesTableViewCell.h"
#import "MImageViewCollectionViewCell.h"

@interface MDetailImagesTableViewCell ()

@property (weak, nonatomic) IBOutlet UICollectionView *imagePreviewCollectionView;

@end

@implementation MDetailImagesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.imagePreviewCollectionView registerNib:[UINib nibWithNibName:@"MImageViewCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MImageViewCollectionViewCell"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MImageViewCollectionViewCell" forIndexPath:indexPath];
    cell.imageDictionary = [self.images objectAtIndex:indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.height, collectionView.frame.size.height);
}
@end
