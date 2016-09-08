//
//  MTextFieldAlertController.h
//  Menu
//
//  Created by Abbin Varghese on 08/09/16.
//  Copyright © 2016 Fuudapp. All rights reserved.
//
@class MTextFieldAlertController;

#import <UIKit/UIKit.h>

@protocol MTextFieldAlertControllerDelegate <NSObject>

-(void)textFieldAlertController:(MTextFieldAlertController*)controller didFinishWithObject:(id)object;

@end

@interface MTextFieldAlertController : UIViewController

@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *messageString;

@property (nonatomic,strong) id <MTextFieldAlertControllerDelegate> delegate;

@end
