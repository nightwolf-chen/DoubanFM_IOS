//
//  FMRootViewController.h
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMApiRequestDelegate.h"
#import "FMUIPlayer.h"

@interface FMRootViewController : UIViewController<FMApiRequestDelegate,FMUIPlayerDelegate>
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;

@end
