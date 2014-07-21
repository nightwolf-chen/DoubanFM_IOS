//
//  FMUserCenterController.h
//  DoubanFM
//
//  Created by nirvawolf on 21/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMUserCenterController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *emailTextField;
@property (retain, nonatomic) IBOutlet UITextField *passwordTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UILabel *loginInfoLabel;


@end
