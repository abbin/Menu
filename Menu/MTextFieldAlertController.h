//
//  MTextFieldAlertController.h
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCuisine.h"

@interface MTextFieldAlertController : UIViewController

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *messageString;

-(void)withCompletionHandler:(void(^)(MCuisine *cuisine))handler;

@end
