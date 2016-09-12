//
//  MAddViewControllerTwo.m
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MAddViewControllerTwo.h"
#import "MRemoteConfig.h"
#import "MConstants.h"
#import "MItemSearchCollectionViewCell.h"
#import "AFNetworking.h"
#import "MLocationPickerController.h"
#import "NSMutableDictionary+MLocation.h"
#import "MCoordinatesPickerController.h"
#import "TLTagsControl.h"
#import "MWorkingDaysPickerController.h"
#import "UIView+Glow.h"
#import "MRestaurant.h"
#import "MManager.h"
#import "MBasicAlertController.h"

@interface MAddViewControllerTwo ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,TLTagsControlDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *corodinatesTextField;
@property (weak, nonatomic) IBOutlet UITextField *tillTextField;
@property (weak, nonatomic) IBOutlet UITextField *fromTextField;

@property (weak, nonatomic) IBOutlet UILabel *nameHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *coordinatesHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumberHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *workingDaysHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *workingTimeHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *tillHeaderLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrain;
@property (nonatomic, strong) UICollectionView *restNameCollectionView;

@property (nonatomic, strong) NSArray *restArray;

@property (strong, nonatomic) NSURLSessionDataTask *dataTask;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) NSString *selectedRestName;

@property (nonatomic, assign) CLLocationCoordinate2D selectedCoordinate;

@property (weak, nonatomic) IBOutlet TLTagsControl *tagControl;
@property (weak, nonatomic) IBOutlet TLTagsControl *workingDayTagControl;

@property (strong, nonatomic) NSMutableArray *workingDaysArray;

@property (nonatomic, strong) UIDatePicker *fromDatePicker;
@property (nonatomic, strong) UIDatePicker *tillDatePicker;

@property (strong, nonatomic) NSString *fromTime;
@property (strong, nonatomic) NSString *tillTime;

@property (weak, nonatomic) IBOutlet UIView *restNameGlowView;
@property (weak, nonatomic) IBOutlet UIView *addressGlowView;
@property (weak, nonatomic) IBOutlet UIView *cityGlowView;
@property (weak, nonatomic) IBOutlet UIView *coordinatesGlowView;

@end

@implementation MAddViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.nameHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.addressHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.cityHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.coordinatesHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.phoneNumberHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.workingDaysHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.workingTimeHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.fromHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.tillHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    
    self.nameTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.addressTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.cityTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.corodinatesTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.tillTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.fromTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    
    self.restNameGlowView.layer.cornerRadius = self.restNameGlowView.frame.size.height/2;
    self.restNameGlowView.layer.masksToBounds = YES;
    
    self.addressGlowView.layer.cornerRadius = self.addressGlowView.frame.size.height/2;
    self.addressGlowView.layer.masksToBounds = YES;
    
    self.cityGlowView.layer.cornerRadius = self.cityGlowView.frame.size.height/2;
    self.cityGlowView.layer.masksToBounds = YES;
    
    self.coordinatesGlowView.layer.cornerRadius = self.coordinatesGlowView.frame.size.height/2;
    self.coordinatesGlowView.layer.masksToBounds = YES;
    
    self.tagControl.tapDelegate = self;
    self.tagControl.tagPlaceholder = @"type here";
    self.workingDayTagControl.tapDelegate = self;
    self.workingDayTagControl.tagPlaceholder = @"tap here";
    [self.tagControl reloadTagSubviews];
    [self.workingDayTagControl reloadTagSubviews];
    
    self.navigationItem.title = @"Restaurant details";
    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self
                                                            action:@selector(barButtonSubmitPressed:)];
    self.navigationItem.rightBarButtonItem = next;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setEstimatedItemSize:CGSizeMake(50, 44)];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    self.restNameCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, 44) collectionViewLayout:layout];
    [self.restNameCollectionView setShowsHorizontalScrollIndicator:NO];
    self.restNameCollectionView.tag = 1;
    [self.restNameCollectionView setDataSource:self];
    [self.restNameCollectionView setDelegate:self];
    
    UIView *inputAccesorryContainer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 88)];
    UIImageView *googlePorwer = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [googlePorwer setImage:[UIImage imageNamed:@"powredByGoogle"]];
    [googlePorwer setContentMode:UIViewContentModeCenter];
    [googlePorwer setBackgroundColor:[UIColor whiteColor]];
    [inputAccesorryContainer addSubview:googlePorwer];
    [inputAccesorryContainer addSubview:self.restNameCollectionView];
    self.nameTextField.inputAccessoryView = inputAccesorryContainer;
    
    [self.restNameCollectionView registerNib:[UINib nibWithNibName:@"MItemSearchCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MItemSearchCollectionViewCell"];
    [self.restNameCollectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    self.fromDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [self.fromDatePicker setBackgroundColor:[UIColor whiteColor]];
    [self.fromDatePicker setDatePickerMode:UIDatePickerModeTime];
    [self.fromDatePicker addTarget:self action:@selector(fromDatepickerChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.fromTextField.inputView = self.fromDatePicker;
    
    self.tillDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    NSDate *currentDate = self.fromDatePicker.date;
    NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:60];
    [self.tillDatePicker setMinimumDate:datePlusOneMinute];
    [self.tillDatePicker setBackgroundColor:[UIColor whiteColor]];
    [self.tillDatePicker setDatePickerMode:UIDatePickerModeTime];
    [self.tillDatePicker addTarget:self action:@selector(tillDatepickerChangedValue:) forControlEvents:UIControlEventValueChanged];
    self.tillTextField.inputView = self.tillDatePicker;

}

- (void)tillDatepickerChangedValue:(UIDatePicker*)sender{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.tillTextField.text = [outputFormatter stringFromDate:sender.date];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [outputFormatter setTimeZone:timeZone];
    [outputFormatter setDateFormat:@"HHmm"];
    NSString *dateString = [outputFormatter stringFromDate:sender.date];
    
    self.tillTime = dateString;
}

- (void)fromDatepickerChangedValue:(UIDatePicker*)sender{
    
    NSDate *currentDate = self.fromDatePicker.date;
    NSDate *datePlusOneMinute = [currentDate dateByAddingTimeInterval:60];
    [self.tillDatePicker setMinimumDate:datePlusOneMinute];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"h:mm a"];
    self.fromTextField.text = [outputFormatter stringFromDate:sender.date];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [outputFormatter setTimeZone:timeZone];
    [outputFormatter setDateFormat:@"HHmm"];
    NSString *dateString = [outputFormatter stringFromDate:sender.date];
    
    self.fromTime = dateString;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.restArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MItemSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MItemSearchCollectionViewCell" forIndexPath:indexPath];
    if ([[self.restArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        cell.cellLabel.text = [NSString stringWithFormat:@"Add '%@' as a new restaurant",[self.restArray objectAtIndex:indexPath.row]];
        cell.cellDetailedLabel.text = @"";
    }
    else{
        cell.cellLabel.text = [[self.restArray objectAtIndex:indexPath.row] objectForKey:@"name"];
        cell.cellDetailedLabel.text = [[self.restArray objectAtIndex:indexPath.row] objectForKey:@"vicinity"];
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.restArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
        self.selectedRestName = [self.restArray objectAtIndex:indexPath.row];
        [self.nameTextField resignFirstResponder];
    }
    else{
        [self.dataTask cancel];
        NSString *placeID = [[self.restArray objectAtIndex:indexPath.row] objectForKey:@"place_id"];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/details/json?placeid=%@&key=%@",placeID,kMGoogleServerKey];
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        
        self.dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (!error) {
                MRestaurant *restObj = [MRestaurant initWithDictionary:[responseObject objectForKey:@"result"]];
                [MManager saveItem:self.item andRestaurant:restObj withImages:self.images];
                [self.view endEditing:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
        [self.dataTask resume];

    }
}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    [self.dataTask cancel];
    if (sender.text.length>0) {
        NSArray* words = [sender.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString* nospacestring = [words componentsJoinedByString:@""];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
//        NSMutableDictionary *loc = [[NSUserDefaults standardUserDefaults]objectForKey:kMCurrentLocationKey];
        
        double lat = 9.976152;
        double lng = 76.293942;
        
        NSString *urlString = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&rankby=distance&type=restaurant&name=%@&key=%@",lat,lng,nospacestring,kMGoogleServerKey];
        NSURL *URL = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:URL];
        [self.activityIndicator startAnimating];
        self.dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (!error) {
                [self.activityIndicator stopAnimating];
                self.restArray = responseObject[@"results"];
                if (self.restArray.count==0) {
                    NSString* result = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    self.restArray = @[result];
                }
                
                [self.restNameCollectionView reloadData];
            }
            else{
                if (error.code != -999) {
                    [self.activityIndicator stopAnimating];
                }
            }
        }];
        
        [self.dataTask resume];

    }
    else{
        self.restArray = nil;
        [self.restNameCollectionView reloadData];
    }
}

-(void)barButtonSubmitPressed:(id)sender{

    if (self.selectedRestName.length==0) {
        [self.restNameGlowView glowOnce];
    }
    else if (self.addressTextField.text.length==0){
        [self.addressGlowView glowOnce];
    }
    else if (self.cityTextField.text.length == 0){
        [self.cityGlowView glowOnce];
    }
    else if (self.corodinatesTextField.text.length == 0){
        [self.coordinatesGlowView glowOnce];
    }
    else{
        if (self.workingDayTagControl.tags.count>0) {
            if (self.fromTime.length>0 && self.tillTime.length>0) {
                MRestaurant *restObject = [MRestaurant initWithName:self.selectedRestName address:self.addressTextField.text coordinate:self.selectedCoordinate phonumber:self.tagControl.tags workingDays:self.workingDaysArray from:self.fromTime till:self.tillTime];
                [MManager saveItem:self.item andRestaurant:restObject withImages:self.images];
                [self.view endEditing:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                MBasicAlertController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MBasicAlertController"];
                vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                vc.titleString = @"Time";
                vc.messageString = @"Time is required when working days are selected";
                [vc withCompletionHandler:^{
                    
                }];
                [self presentViewController:vc animated:NO completion:nil];
            }
        }
        else{
            MRestaurant *restObject = [MRestaurant initWithName:self.selectedRestName address:self.addressTextField.text coordinate:self.selectedCoordinate phonumber:self.tagControl.tags workingDays:self.workingDaysArray from:self.fromTime till:self.tillTime];
            [MManager saveItem:self.item andRestaurant:restObject withImages:self.images];
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (IS_IPHONE_6P) {
        switch (textField.tag) {
            case 4:
            case 5:{
                self.topConstrain.constant = -166;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
    }
    else if (IS_IPHONE_6){
        switch (textField.tag) {
            case 4:
            case 5:{
                self.topConstrain.constant = -236;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    else if (IS_IPHONE_5){
        switch (textField.tag) {
            case 1:{
                self.topConstrain.constant = -20;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
            case 4:
            case 5:{
                self.topConstrain.constant = -336;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
    else{
        switch (textField.tag) {
            case 1:{
                self.topConstrain.constant = -68;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
            case 4:
            case 5:{
                self.topConstrain.constant = -425;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (textField.tag == 0) {
        textField.text = self.selectedRestName;
        self.restArray = nil;
        [self.restNameCollectionView reloadData];
    }

    self.topConstrain.constant = 20;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    switch (textField.tag) {
        case 2:{
            [self.view endEditing:YES];
            UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MLocationPickerController"];
            MLocationPickerController *vc = nav.viewControllers[0];
            [vc withCompletionHandler:^(NSMutableDictionary *location) {
                self.cityTextField.text = location.locationFullName;
            }];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
            break;
        case 3:{
            [self.view endEditing:YES];
            UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MCoordinatesPickerController"];
            MCoordinatesPickerController *vc = nav.viewControllers[0];
            [vc withCompletionHandler:^(CLLocationCoordinate2D coordinates) {
                self.corodinatesTextField.text = [NSString stringWithFormat:@"%f, %f",coordinates.latitude,coordinates.longitude];
                self.selectedCoordinate = coordinates;
            }];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
            break;
        default:
            return YES;
            break;
    }
}

- (IBAction)didTapOnView:(id)sender {
    [self.view endEditing:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - TLTagsControlDelegate -

-(void)tagsControlDidEndEditing:(TLTagsControl *)tagsControl{
    self.topConstrain.constant = -20;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)tagsControlDidBeginEditing:(TLTagsControl *)tagsControl{
    if (IS_IPHONE_4_OR_LESS) {
        self.topConstrain.constant = -327;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else if (IS_IPHONE_5){
        self.topConstrain.constant = -327;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else if (IS_IPHONE_6){
        self.topConstrain.constant = -175;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else{
        self.topConstrain.constant = -70;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

-(BOOL)tagsControlShouldBeginEditing:(TLTagsControl *)tagsControl{
    if (tagsControl.tag == 0) {
        return YES;
    }
    else{
        [self.view endEditing:YES];
        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MWorkingDaysPickerController"];
        MWorkingDaysPickerController *vc = [nav.viewControllers firstObject];
        vc.workingDaysArray = self.workingDaysArray;
        [vc withCompletionHandler:^(NSMutableArray *days) {
            NSMutableArray *tags = [NSMutableArray new];
            for (NSDictionary *dict in days) {
                [tags addObject:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"close"] objectForKey:@"dayName"]]];
            }
            self.workingDayTagControl.tags = tags;
            self.workingDayTagControl.tagPlaceholder = @"";
            [self.workingDayTagControl reloadTagSubviews];
            self.workingDaysArray = days;
        }];
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
}

-(void)tagsControl:(TLTagsControl *)tagsControl didDeleteTagAtIndex:(NSInteger)index{
    if (tagsControl.tag == 1) {
        [self.workingDaysArray removeObjectAtIndex:index];
    }
}

@end
