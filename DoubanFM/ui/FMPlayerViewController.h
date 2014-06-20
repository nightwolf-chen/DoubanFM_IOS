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

@property (retain, nonatomic) IBOutlet UILabel *durationLabel;

@property (retain, nonatomic) IBOutlet UILabel *artistLabel;

@property (retain, nonatomic) IBOutlet UIImageView *songImgView;
@property (retain, nonatomic) IBOutlet UILabel *songInfoLabel;
@property (retain, nonatomic) IBOutlet UISlider *songProgressSlider;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic, readonly) FMUIPlayer *player;

//If you set this channelId property, you will force the controller load songs from server and restart player. 
@property (copy, nonatomic) NSString *channelId;

@end
