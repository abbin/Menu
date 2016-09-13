//
//  MDetailImagesTableViewCell.h
//  Menu
//
//  Created by Abbin Varghese on 13/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDetailImagesTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *images;

@end
