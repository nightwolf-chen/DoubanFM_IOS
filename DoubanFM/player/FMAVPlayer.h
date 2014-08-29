//
//  FMPlayer.h
//  DoubanFM
//
//  Created by nirvawolf on 30/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AVPlayer;
@class FMSong;

@interface FMAVPlayer : NSObject


@property (nonatomic,retain) AVPlayer *player;

- (id)init;
- (void)pause;
- (void)setVolume:(float)v;

@end
