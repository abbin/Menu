//
//  MCuisinePickerController.h
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <ParseUI/ParseUI.h>
#import "MCuisine.h"

@interface MCuisinePickerController : PFQueryTableViewController

-(void)withCompletionHandler:(void(^)(MCuisine *cuisine))handler;

@end
