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

@interface MAddViewControllerTwo ()<UITextFieldDelegate>

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
        case 2:
            return NO;
            break;
        case 3:
            return NO;
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
