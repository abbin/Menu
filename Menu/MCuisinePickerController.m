//
//  MCuisinePickerController.m
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import "MCuisinePickerController.h"
#import "MConstants.h"
#import <Parse/Parse.h>
#import "MRemoteConfig.h"
#import "MTextFieldAlertController.h"

@interface MCuisinePickerController ()<MTextFieldAlertControllerDelegate>

@end

@implementation MCuisinePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // The className to query on
        self.parseClassName = kMCuisineClassNameKey;
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        self.objectsPerPage = 100;
    }
    
    return self;
}

- (PFQuery *)queryForTable {
    
    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    [query orderByAscending:kMCuisineNameKey];
    
    return query;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(PFTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(MCuisine *)object{
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PFTableViewCell"];
    cell.textLabel.font = [UIFont fontWithName:[MRemoteConfig secondaryFontName] size:15.0];
    cell.textLabel.text = object.cuisineName;
    return cell;
}

- (IBAction)addNewCuisine:(id)sender {
//    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"New cuisine"
//                                                                              message: @"Add a new cuisine to our database"
//                                                                       preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
//        textField.placeholder = @"e.g. Chinese";
//        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
//    }];
//
//    [alertController addAction:[UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        NSArray * textfields = alertController.textFields;
//        UITextField * namefield = textfields[0];
//        [namefield resignFirstResponder];
//        NSString* result = [namefield.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//        
//        if (result.length>0) {
//            MCuisine *cuisine = [MCuisine object];
//            cuisine.cuisineName = result;
//            
//            [cuisine saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                if (succeeded) {
//                    [self dismissViewControllerAnimated:YES completion:^{
//                        if ([self.delegate respondsToSelector:@selector(cuisinePickerController:didFinishWithCuisine:)]) {
//                            [self.delegate cuisinePickerController:self didFinishWithCuisine:cuisine];
//                        }
//                    }];
//                } else {
//                    // There was a problem, check error.description
//                }
//            }];
//        }
//        
//    }]];
//    [self presentViewController:alertController animated:YES completion:nil];
    
    MTextFieldAlertController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTextFieldAlertController"];
    vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    vc.delegate = self;
    vc.titleString = @"New +";
    vc.messageString = @"Add a new cuisine to our database";
    [self presentViewController:vc animated:NO completion:nil];
    
};

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(cuisinePickerController:didFinishWithCuisine:)]) {
            [self.delegate cuisinePickerController:self didFinishWithCuisine:[self.objects objectAtIndex:indexPath.row]];
        }
    }];
}

-(void)textFieldAlertController:(MTextFieldAlertController *)controller didFinishWithObject:(id)object{
    if ([object isKindOfClass:[MCuisine class]]) {
        [self dismissViewControllerAnimated:YES completion:^{
            if ([self.delegate respondsToSelector:@selector(cuisinePickerController:didFinishWithCuisine:)]) {
                [self.delegate cuisinePickerController:self didFinishWithCuisine:object];
            }
        }];
    }
}

@end
