//
//  FMTabarViewController.h
//  DoubanFM
//
//  Created by nirvawolf on 17/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTabbarView.h"

@class FMTabbarView;
@class FMPlayerView;

@interface FMTabarViewController : UIViewController<FMTabbarViewDelegate>

@property (nonatomic,retain) NSArray *tabViews;
@property (nonatomic,retain) FMTabbarView *tabbarView;
@property (nonatomic,retain) FMPlayerView *playerView;


@end
