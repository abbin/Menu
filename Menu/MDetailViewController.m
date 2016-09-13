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

@interface MDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end

@implementation MDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailTableView.estimatedRowHeight = 100;
    self.detailTableView.rowHeight = UITableViewAutomaticDimension;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.item.itemOpenHours.length>0) {
        return 3;
    }
    else{
        return 2;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MDetailMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDetailMainTableViewCell"];
        cell.item = self.item;
        return cell;
    }
    else if(indexPath.section == 1){
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
    else{
        MDetailImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MDetailImagesTableViewCell"];
        cell.images = self.item.itemImageArray;
        return cell;
    }
}


@end
