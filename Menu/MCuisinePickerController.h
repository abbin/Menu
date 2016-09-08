//
//  MCuisinePickerController.h
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

@class MCuisinePickerController;

#import <ParseUI/ParseUI.h>
#import "MCuisine.h"

@protocol MCuisinePickerControllerDelegate <NSObject>

-(void)cuisinePickerController:(MCuisinePickerController*)picker didFinishWithCuisine:(MCuisine*)Cuisine;

@end

@interface MCuisinePickerController : PFQueryTableViewController

@property (nonatomic, strong) id <MCuisinePickerControllerDelegate> delegate;

@end
