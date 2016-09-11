//
//  MWorkingDaysPickerController.h
//  Menu
//
//  Created by Abbin Varghese on 09/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MWorkingDaysPickerController : UIViewController

-(void)withCompletionHandler:(void(^)(NSMutableArray *days))handler;

@property (strong, nonatomic) NSMutableArray *workingDaysArray;

@end
