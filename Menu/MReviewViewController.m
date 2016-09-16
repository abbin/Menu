//
//  MReviewViewController.m
//  Menu
//
//  Created by Abbin Varghese on 16/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MReviewViewController.h"
#import "MRemoteConfig.h"
#import "MImageViewCollectionViewCell.h"
#import "MConstants.h"
#import "MManager.h"

@interface MReviewViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *reviewTextView;
@property (weak, nonatomic) IBOutlet UIButton *one;
@property (weak, nonatomic) IBOutlet UIButton *onePointFive;
@property (weak, nonatomic) IBOutlet UIButton *two;
@property (weak, nonatomic) IBOutlet UIButton *twoPointFive;
@property (weak, nonatomic) IBOutlet UIButton *three;
@property (weak, nonatomic) IBOutlet UIButton *threePointFive;
@property (weak, nonatomic) IBOutlet UIButton *four;
@property (weak, nonatomic) IBOutlet UIButton *fourPointFive;
@property (weak, nonatomic) IBOutlet UIButton *five;
@property (weak, nonatomic) IBOutlet UIView *reviewTouchPad;
@property (assign, nonatomic) NSInteger rating;
@property (weak, nonatomic) IBOutlet UICollectionView *imagePreviewCollectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstrain;

@end

@implementation MReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reviewTextView.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:10.0];
    [self.imagePreviewCollectionView registerNib:[UINib nibWithNibName:@"MImageViewCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MImageViewCollectionViewCell"];
    
    UIBarButtonItem* next = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStylePlain target:self
                                                            action:@selector(barButtonSubmitPressed:)];
    self.navigationItem.rightBarButtonItem = next;
}

-(void)barButtonSubmitPressed:(id)sender{
    if (self.rating>0 && self.reviewTextView.text.length>0){
        NSString* result = [self.reviewTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [MManager saveReview:result rating:self.rating forItem:self.item withImages:self.images];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MImageViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MImageViewCollectionViewCell" forIndexPath:indexPath];
    cell.cellImage = [self.images objectAtIndex:indexPath.row];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    UIImage *image = [self.images objectAtIndex:indexPath.row];
    return CGSizeMake((collectionView.frame.size.height*image.size.width/image.size.height)-5, collectionView.frame.size.height-5);
}

- (IBAction)didTapOnBackgroundView:(id)sender {
    [self.view endEditing:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@"say somthing nice"]) {
        textView.text = @"";
        textView.textColor = [UIColor darkTextColor];
    }
    
    if (IS_IPHONE_6P) {
        self.topConstrain.constant = -115;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else if (IS_IPHONE_6){
        self.topConstrain.constant = -130;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else if (IS_IPHONE_5){
        self.topConstrain.constant = -165;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    else{
        self.topConstrain.constant = -200;
        [UIView animateWithDuration:0.3 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"say somthing nice";
        textView.textColor = [UIColor colorWithWhite:0 alpha:0.25];
    }
    
    self.topConstrain.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}



- (IBAction)didPanOnView:(UIPanGestureRecognizer *)sender {
    int percentage = [sender locationInView:self.reviewTouchPad].x/self.reviewTouchPad.frame.size.width*100;
    NSLog(@"%d",percentage);
    CGFloat time = 0.3;
    if (percentage>88) {
        self.rating = 5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[MRemoteConfig colorFour]];
            [self.fourPointFive setBackgroundColor:[MRemoteConfig colorFourPointFive]];
            [self.five setBackgroundColor:[MRemoteConfig colorFive]];
        }];
    }
    else if (percentage>77){
        self.rating = 4.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[MRemoteConfig colorFour]];
            [self.fourPointFive setBackgroundColor:[MRemoteConfig colorFourPointFive]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>66){
        self.rating = 4;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[MRemoteConfig colorFour]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>55){
        self.rating = 3.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>44){
        self.rating = 3;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>33){
        self.rating = 2.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>22){
        self.rating = 2;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>12){
        self.rating = 1.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.twoPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else{
        self.rating = 1;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.two setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.twoPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
}

- (IBAction)didTapOnView:(UITapGestureRecognizer *)sender {
    int percentage = [sender locationInView:self.reviewTouchPad].x/self.reviewTouchPad.frame.size.width*100;
    NSLog(@"%d",percentage);
    CGFloat time = 0.3;
    if (percentage>88) {
        self.rating = 5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[MRemoteConfig colorFour]];
            [self.fourPointFive setBackgroundColor:[MRemoteConfig colorFourPointFive]];
            [self.five setBackgroundColor:[MRemoteConfig colorFive]];
        }];
    }
    else if (percentage>77){
        self.rating = 4.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[MRemoteConfig colorFour]];
            [self.fourPointFive setBackgroundColor:[MRemoteConfig colorFourPointFive]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>66){
        self.rating = 4;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[MRemoteConfig colorFour]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>55){
        self.rating = 3.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[MRemoteConfig colorThreePointFive]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>44){
        self.rating = 3;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[MRemoteConfig colorThree]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>33){
        self.rating = 2.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[MRemoteConfig colorTwoPointFive]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>22){
        self.rating = 2;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[MRemoteConfig colorTwo]];
            [self.twoPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else if (percentage>12){
        self.rating = 1.5;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[MRemoteConfig colorOnePointFive]];
            [self.two setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.twoPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
    else{
        self.rating = 1;
        [UIView animateWithDuration:time animations:^{
            [self.one setBackgroundColor:[MRemoteConfig colorOne]];
            [self.onePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.two setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.twoPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.three setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.threePointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.four setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.fourPointFive setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            [self.five setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        }];
        
    }
}

@end
