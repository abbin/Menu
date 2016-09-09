//
//  MLocationPickerController.h
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLocationPickerController : UIViewController

-(void)withCompletionHandler:(void(^)(NSMutableDictionary *location))handler;

@end
