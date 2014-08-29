//
//  FMPlayer.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-29.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMSong,FMChannel;

@interface FMPlayer : NSObject

@property (nonatomic,readonly) FMSong *currentSong;
@property (nonatomic,readonly) FMChannel *currentChannel;
@property (nonatomic,readonly) NSTimeInterval currentTime;
@property (nonatomic,readonly) NSTimeInterval totalTime;
@property (nonatomic,copy) NSArray *songQueue;

- (void)play;
- (void)stop;
- (void)next;
- (void)pause;
- (void)resume;

- (void)like;
- (void)dislike;
- (void)skip;

+ (instancetype)defaultPlayer;

@end
