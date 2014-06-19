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

@interface FMPlayerViewController : UIViewController<FMApiRequestDelegate,FMUIPlayerDelegate>

@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic, readonly) FMUIPlayer *player;

@end
