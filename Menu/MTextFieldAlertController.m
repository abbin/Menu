//
//  MTextFieldAlertController.m
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MTextFieldAlertController.h"
#import "MRemoteConfig.h"

@interface MTextFieldAlertController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *horizontalConstrain;
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailedLabel;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (nonatomic, strong) void(^completionHandler)(MCuisine *);

@end

@implementation MTextFieldAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.alpha = 0;
    self.titileLabel.font = [UIFont fontWithName:[MRemoteConfig primaryFontName] size:30.0];
    self.detailedLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.doneButton.titleLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    self.textField.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:12.0];
    [self.doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    self.titileLabel.text = self.titleString;
    self.detailedLabel.text = self.messageString;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.view.alpha = 1;
    } completion:^(BOOL finished) {
        [self.textField becomeFirstResponder];
    }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.horizontalConstrain.constant = -105;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)withCompletionHandler:(void(^)(MCuisine *cuisine))handler{
    _completionHandler = handler;
}

- (IBAction)done:(id)sender {
    if (self.textField.text.length>0) {
        NSString* result = [self.textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        if (result.length>0) {
            MCuisine *cuisine = [MCuisine object];
            cuisine.cuisineName = result;
            
            NSArray* words = [result componentsSeparatedByCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            NSString* trimmedString = [words componentsJoinedByString:@""];
            NSString *lowString = [trimmedString lowercaseString];
            
            cuisine.cuisineCappedName = lowString;

            [self.activityIndicator startAnimating];
            [cuisine saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self.activityIndicator stopAnimating];
                if (succeeded) {
                    [self.textField resignFirstResponder];
                    [self dismissViewControllerAnimated:YES completion:^{
                        _completionHandler(cuisine);
                    }];
                }
            }];
        }

    }
    else{
        [UIView animateWithDuration:0.1 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}


@end
