//
//  MAddViewControllerOne.m
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MAddViewControllerOne.h"
#import "MImageCollectionViewCell.h"
#import "MRemoteConfig.h"
#import "MAddViewControllerTwo.h"
#import "MConstants.h"
#import "MItemSearchCollectionViewCell.h"
#import "MCuisinePickerController.h"
#import "UIView+Glow.h"
#import "MItem.h"

@interface MAddViewControllerOne ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate,UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *cuisineHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceHeaderLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionheaderLabel;

@property (weak, nonatomic) IBOutlet UIView *nameGlowView;
@property (weak, nonatomic) IBOutlet UIView *cuisineGlowView;
@property (weak, nonatomic) IBOutlet UIView *priceGlowView;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *cuisineTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrain;
@property (nonatomic, strong) UICollectionView *itemNameCollectionView;

@property (nonatomic, strong) NSMutableArray *itemsArray;
@property (nonatomic, strong) NSString *selectedItemName;
@property (nonatomic, strong) MCuisine *selectedCuisine;

@end

@implementation MAddViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.cuisineHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.priceHeaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    self.descriptionheaderLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    
    self.nameTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.cuisineTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.priceTextField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.descriptionTextView.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    
    self.nameGlowView.layer.cornerRadius = self.nameGlowView.frame.size.height/2;
    self.nameGlowView.layer.masksToBounds = YES;
    
    self.cuisineGlowView.layer.cornerRadius = self.cuisineGlowView.frame.size.height/2;
    self.cuisineGlowView.layer.masksToBounds = YES;
    
    self.priceGlowView.layer.cornerRadius = self.priceGlowView.frame.size.height/2;
    self.priceGlowView.layer.masksToBounds = YES;

    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self
                                                                  action:@selector(barButtonNextPressed:)];
    self.navigationItem.rightBarButtonItem = next;
    self.navigationItem.title = @"Item details";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [layout setEstimatedItemSize:CGSizeMake(50, 44)];
    [layout setMinimumLineSpacing:0];
    [layout setMinimumInteritemSpacing:0];
    self.itemNameCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) collectionViewLayout:layout];
    [self.itemNameCollectionView setShowsHorizontalScrollIndicator:NO];
    self.itemNameCollectionView.tag = 1;
    [self.itemNameCollectionView setDataSource:self];
    [self.itemNameCollectionView setDelegate:self];
    self.nameTextField.inputAccessoryView = self.itemNameCollectionView;
    [self.itemNameCollectionView registerNib:[UINib nibWithNibName:@"MItemSearchCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MItemSearchCollectionViewCell"];
    [self.itemNameCollectionView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}

-(void)barButtonNextPressed:(id)sender{
//    if (self.selectedItemName.length == 0){
//        [self.nameGlowView glowOnceWithColor:[UIColor redColor]];
//    }
//    else if (self.selectedCuisine == nil){
//        [self.cuisineGlowView glowOnceWithColor:[UIColor redColor]];
//    }
//    else if ([self.priceTextField.text isEqualToString:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol]] || self.priceTextField.text.length==0){
//        [self.priceGlowView glowOnceWithColor:[UIColor redColor]];
//    }
//    else{
//        [self.view endEditing:YES];
//        
//        NSString *newStr = [self.priceTextField.text substringFromIndex:1];
//        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//        NSNumber *price = [f numberFromString:newStr];
//        
//        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//        [formatter setLocale:[NSLocale currentLocale]];
//        
//        if ([self.descriptionTextView.text isEqualToString:@"type here"]) {
//            self.descriptionTextView.text = @"";
//        }
    
        MAddViewControllerTwo *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MAddViewControllerTwo"];
//        vc.images = self.images;
//        
//        vc.item = [MItem object];
//        vc.item.itemName = self.nameTextField.text;
//        vc.item.itemPrice = price;
//        vc.item.itemCuisine = self.selectedCuisine;
//        vc.item.itemDescription = self.descriptionTextView.text;
//        vc.item.itemCurrency = [formatter currencyCode];
//        vc.item.itemCurrencySymbol = [formatter currencySymbol];
//        vc.item.itemUser = [MUser currentUser];
//        NSArray* words = [self.nameTextField.text componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        NSString* trimmedString = [words componentsJoinedByString:@""];
//        vc.item.itemCappedName = [trimmedString lowercaseString];
        
        [self.navigationController pushViewController:vc animated:YES];
//    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 0) {
        return self.images.count;
    }
    else{
        return self.itemsArray.count;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 0) {
        MImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MImageCollectionViewCell" forIndexPath:indexPath];
        cell.cellImageView.image = [self.images objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        MItemSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MItemSearchCollectionViewCell" forIndexPath:indexPath];
        if ([[self.itemsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
            cell.cellLabel.text = [NSString stringWithFormat:@"Add '%@' as a new item",[self.itemsArray objectAtIndex:indexPath.row]];
            cell.cellDetailedLabel.text = @"";
        }
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 1) {
        if ([[self.itemsArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]]) {
            self.selectedItemName = [self.itemsArray objectAtIndex:indexPath.row];
            [self.nameTextField resignFirstResponder];
        }
        
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 0) {
        UIImage *image = [self.images objectAtIndex:indexPath.row];
        return CGSizeMake((collectionView.frame.size.height*image.size.width/image.size.height)-2, collectionView.frame.size.height-2);
    }
    else{
        return CGSizeMake(1, 1);
    }
}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    if (sender.text.length > 0) {
        if (self.itemsArray == nil) {
            self.itemsArray = [NSMutableArray array];
        }
        [self.itemsArray removeAllObjects];
        NSString* result = [sender.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        [self.itemsArray addObject:result];
        [self.itemNameCollectionView reloadData];
    }
    else{
        self.itemsArray = nil;
        [self.itemNameCollectionView reloadData];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 1) {
        
        UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"MCuisinePickerController"];
        MCuisinePickerController *vc = nav.viewControllers[0];
        [vc withCompletionHandler:^(MCuisine *cuisine) {
            self.selectedCuisine = cuisine;
            self.cuisineTextField.text = cuisine.cuisineName;
        }];
        [self presentViewController:nav animated:YES completion:nil];
        
        return NO;
    }
    else{
        return YES;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (IS_IPHONE_6P) {
        switch (textField.tag) {
            case 0:{
                self.topConstrain.constant = -173;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
//            case 1:{
//                self.topConstrain.constant = -183;
//                [UIView animateWithDuration:0.3 animations:^{
//                    [self.view layoutIfNeeded];
//                }];
//            }
//                break;
            case 2:{
                self.topConstrain.constant = -193;
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
            case 0:{
                self.topConstrain.constant = -173;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
//            case 1:{
//                self.topConstrain.constant = -203;
//                [UIView animateWithDuration:0.3 animations:^{
//                    [self.view layoutIfNeeded];
//                }];
//            }
//                break;
            case 2:{
                self.topConstrain.constant = -233;
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
            case 0:{
                self.topConstrain.constant = -175;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
//            case 1:{
//                self.topConstrain.constant = -258;
//                [UIView animateWithDuration:0.3 animations:^{
//                    [self.view layoutIfNeeded];
//                }];
//            }
//                break;
            case 2:{
                self.topConstrain.constant = -344;
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
            case 0:{
                self.topConstrain.constant = -193;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
//            case 1:{
//                self.topConstrain.constant = -278;
//                [UIView animateWithDuration:0.3 animations:^{
//                    [self.view layoutIfNeeded];
//                }];
//            }
//                break;
            case 2:{
                self.topConstrain.constant = -364;
                [UIView animateWithDuration:0.3 animations:^{
                    [self.view layoutIfNeeded];
                }];
            }
                break;
                
            default:
                break;
        }

    }
    
    if (textField.tag == 2) {
        if ([textField.text isEqualToString:@""]) {
            textField.text = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
        }
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.tag == 2) {
        if ((range.location == 0 && range.length == 1) || (range.location > 6 && range.length == 0)) {
            return NO;
        }
        else{
            return YES;
        }
    }
    else{
        return YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.tag == 2) {
        if ([textField.text isEqualToString:[[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol]]) {
            textField.text = @"";
        }
    }
    
    if (textField.tag == 0) {
        textField.text = self.selectedItemName;
        self.itemsArray = nil;
        [self.itemNameCollectionView reloadData];
    }
    self.topConstrain.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"type here"]) {
        textView.text = @"";
    }
    
    if (IS_IPHONE_6P) {
        self.topConstrain.constant = -183;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else if (IS_IPHONE_6){
        self.topConstrain.constant = -253;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else if (IS_IPHONE_5){
        self.topConstrain.constant = -344;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else{
        self.topConstrain.constant = -440;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }

}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"type here";
    }
    
    self.topConstrain.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}



- (IBAction)didTapOnView:(id)sender {
    [self.view endEditing:YES];
}

@end
