//
//  MBasicAlertController.h
//  Menu
//
//  Created by Abbin Varghese on 10/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MBasicAlertController : UIViewController

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *messageString;

-(void)withCompletionHandler:(void(^)())handler;

@end
