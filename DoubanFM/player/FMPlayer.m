//
//  FMPlayer.m
//  DoubanFM
//
//  Created by nirvawolf on 30/5/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "FMSong.h"

@implementation FMPlayer

- (id)init
{
    self = [super init];
    
    if (self) {
        _player = [[AVPlayer alloc] init];
    }
    
    return self;
}



- (void)pause
{
    [_player pause];
}

- (void)setVolume:(float)v
{
    _player.volume = v;
}

@end
