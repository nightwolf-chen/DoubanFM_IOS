//
//  FMLoginViewController.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-21.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMLoginViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *usernameTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;

@end
