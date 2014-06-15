//
//  FMUIPlayer.h
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayer.h"

@class FMSong;

@interface FMUIPlayer : FMPlayer

@property (nonatomic,retain) NSMutableArray *songQueue;

- (id)initWithSongs:(NSArray *)songs;

- (void)start;
- (void)next;

- (FMSong *)getPlayingSong;

@end
