//
//  MNearbyTableViewController.m
//  Menu
//
//  Created by Abbin Varghese on 07/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MNearbyTableViewController.h"
#import "MConstants.h"
#import "UIViewController+YMSPhotoHelper.h"
#import "MRemoteConfig.h"
#import "MAddViewControllerOne.h"
#import "MNearbyTableViewCell.h"

@interface MNearbyTableViewController ()<YMSPhotoPickerViewControllerDelegate>

@end

@implementation MNearbyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 434;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

- (IBAction)addNew:(id)sender {
    YMSPhotoPickerViewController *pickerViewController = [[YMSPhotoPickerViewController alloc] init];
    pickerViewController.numberOfPhotoToSelect = 3;
    
    pickerViewController.theme.titleLabelTextColor = [UIColor blackColor];
    pickerViewController.theme.titleLabelFont = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:17.0];
    pickerViewController.theme.cameraVeilColor = [UIColor colorWithWhite:0.5 alpha:1];
    pickerViewController.theme.albumNameLabelFont = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    pickerViewController.theme.selectionOrderLabelFont = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    pickerViewController.theme.orderTintColor = [UIColor redColor];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:pickerViewController];
    [self yms_presentCustomAlbumPhotoView:nav delegate:self];
}

- (void)photoPickerViewControllerDidReceivePhotoAlbumAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow photo album access?", nil) message:NSLocalizedString(@"Need your permission to access photo albumbs", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewControllerDidReceiveCameraAccessDenied:(YMSPhotoPickerViewController *)picker
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Allow camera access?", nil) message:NSLocalizedString(@"Need your permission to take a photo", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    [alertController addAction:dismissAction];
    [alertController addAction:settingsAction];
    
    // The access denied of camera is always happened on picker, present alert on it to follow the view hierarchy
    [picker presentViewController:alertController animated:YES completion:nil];
}

- (void)photoPickerViewController:(YMSPhotoPickerViewController *)picker didFinishPickingImages:(NSArray *)photoAssets{
    
    PHImageManager *imageManager = [[PHImageManager alloc] init];
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    options.networkAccessAllowed = YES;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.synchronous = YES;
    
    NSMutableArray *mutableImages = [NSMutableArray array];
    
    for (PHAsset *asset in photoAssets) {
        [imageManager requestImageDataForAsset:asset
                                       options:nil
                                 resultHandler:^(NSData * _Nullable imageData,
                                                 NSString * _Nullable dataUTI,
                                                 UIImageOrientation orientation,
                                                 NSDictionary * _Nullable info) {
                                     
                                     UIImage *image = [UIImage imageWithData:imageData];
                                     [mutableImages addObject:image];
                                     
                                     if (photoAssets.count == mutableImages.count) {
                                         MAddViewControllerOne *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MAddViewControllerOne"];
                                         vc.images = mutableImages;
                                         [picker.navigationController pushViewController:vc animated:YES];
                                     }
                                 }];
    }
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = kMItemsClassNameKey;
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
    }
    
    return self;
}

- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    [query includeKeys:@[kMItemsUserKey,kMItemRestaurantKey]];
    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];
    return query;
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(MItem *)object{
    MNearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MNearbyTableViewCell"];
    cell.cellItem = object;
    return cell;
}

@end
