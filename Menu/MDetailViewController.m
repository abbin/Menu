//
//  MDetailViewController.m
//  Menu
//
//  Created by Abbin Varghese on 12/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MDetailViewController.h"
#import "MConstants.h"
#import "MDetailMainTableViewCell.h"
#import "MRemoteConfig.h"
#import "MDetailImagesTableViewCell.h"
#import "MRestaurantAddressTableViewCell.h"
#import "MReviewTableViewCell.h"

@interface MDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@property (nonatomic, assign) NSInteger indexMainHeader;
@property (nonatomic, assign) NSInteger indexIsOpen;
@property (nonatomic, assign) NSInteger indexImages;
@property (nonatomic, assign) NSInteger indexAddress;
@property (nonatomic, assign) NSInteger indexPhoneNumber;
@property (nonatomic, assign) NSInteger indexReview;
@property (nonatomic, assign) NSInteger numberOfSections;

@end

@implementation MDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailTableView.estimatedRowHeight = 100;
    self.detailTableView.rowHeight = UITableViewAutomaticDimension;
    
    _indexMainHeader = 0;
    _indexIsOpen = 1;
    _indexImages = 2;
    _indexAddress = 3;
    _indexPhoneNumber = 4;
    _indexReview = 5;
    _numberOfSections = 6;
    
    if (self.item.itemRestaurant.restaurantWorkingHours == nil) {
        _indexIsOpen = 99;
        
        _indexMainHeader = 0;
        _indexImages = _indexImages-1;
        _indexAddress = _indexAddress-1;
        _indexPhoneNumber = _indexPhoneNumber-1;
        _indexReview = _indexReview-1;
        _numberOfSections = _numberOfSections-1;
    }
    if (self.item.itemRestaurant.restaurantPhoneNumbers == nil) {
        _indexPhoneNumber = 99;
        
        _indexMainHeader = 0;
        _indexReview = _indexReview-1;
        _numberOfSections = _numberOfSections-1;
    }
    if (self.item.itemReviewArray == nil){
        _indexReview = 99;
        _numberOfSections = _numberOfSections - 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _numberOfSections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == _indexPhoneNumber) {
        return self.item.itemRestaurant.restaurantPhoneNumbers.count;
    }
    else if (section == _indexReview){
        return MIN(3, self.item.itemReviewArray.count+1);
    }
    else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == _indexMainHeader) {
        MDetailMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDetailMainTableViewCell"];
        cell.item = self.item;
        return cell;
    }
    else if(indexPath.section == _indexIsOpen){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        if ([self.item.itemOpen boolValue]) {
            NSMutableAttributedString *atString = [[NSMutableAttributedString alloc] initWithString:self.item.itemOpenHours];
            [atString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:[MRemoteConfig primaryFontName] size:10.0]
                             range:NSMakeRange(0, atString.length)];
            [atString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:[MRemoteConfig primaryFontName] size:10.0]
                             range:NSMakeRange(0, 8)];
            [atString addAttribute:NSForegroundColorAttributeName
                             value:[MRemoteConfig openGreen]
                             range:NSMakeRange(0, 8)];
            cell.textLabel.attributedText = atString;
        }
        else{
            NSMutableAttributedString *atString = [[NSMutableAttributedString alloc] initWithString:self.item.itemOpenHours];
            [atString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:[MRemoteConfig primaryFontName] size:10.0]
                             range:NSMakeRange(0, atString.length)];
            [atString addAttribute:NSFontAttributeName
                             value:[UIFont fontWithName:[MRemoteConfig primaryFontName] size:10.0]
                             range:NSMakeRange(0, 10)];
            [atString addAttribute:NSForegroundColorAttributeName
                             value:[MRemoteConfig closedRed]
                             range:NSMakeRange(0, 10)];
            cell.textLabel.attributedText = atString;
        }
        return cell;
    }
    else if(indexPath.section == _indexImages){
        MDetailImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDetailImagesTableViewCell"];
        cell.images = self.item.itemImageArray;
        return cell;
    }
    else if(indexPath.section == _indexAddress){
        MRestaurantAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRestaurantAddressTableViewCell"];
        cell.restaurant = self.item.itemRestaurant;
        return cell;
    }
    else if (indexPath.section == _indexPhoneNumber){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MRestaurantPhoneNumberTableViewCell"];
        cell.textLabel.text = [self.item.itemRestaurant.restaurantPhoneNumbers objectAtIndex:indexPath.row];
        cell.textLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
        return cell;
    }
    else if (indexPath.section == _indexReview){
        MReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MReviewTableViewCell"];
        return cell;
    }
    else{
        return nil;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    _indexMainHeader = 0;
    _indexIsOpen = 1;
    _indexImages = 2;
    _indexAddress = 3;
    _indexPhoneNumber = 4;
    if (section == _indexIsOpen) {
        return @"Status";
    }
    else if (section == _indexImages){
        return @"Images";
    }
    else if (section == _indexAddress){
        return @"Address";
    }
    else if (section == _indexPhoneNumber){
        return @"Phone number";
    }
    else{
        return nil;
    }
}


@end
