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

@interface MAddViewControllerTwo ()<UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

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
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (IS_IPHONE_6P) {
        switch (textField.tag) {
            case 4:
            case 5:{
                self.topConstrain.constant = -200;
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
                self.topConstrain.constant = -250;
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
                self.topConstrain.constant = -350;
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
                self.topConstrain.constant = -440;
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
        case 0:
            return YES;
            break;
        case 1:
            return YES;
            break;
        case 2:{
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
            UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MCoordinatesPickerController"];
            MCoordinatesPickerController *vc = nav.viewControllers[0];
            [self presentViewController:nav animated:YES completion:nil];
            return NO;
        }
            
            break;
        case 4:
            return YES;
            break;
        case 5:
            return YES;
            break;
            
        default:
            return YES;
            break;
    }
}

- (IBAction)didTapOnView:(id)sender {
    [self.view endEditing:YES];
}

@end
