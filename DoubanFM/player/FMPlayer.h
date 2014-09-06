//
//  FMPlayer.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-29.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FMPlayerStatus){
    FMPlayerPlaying,
    FMPlayerStoped,
    FMPlayerPaused,
    FMPlayerUnprepared,
    FMPlayerReadyToPlay,
    FMPlayerAllFinished
};

@class FMSong,FMChannel;

@interface FMPlayer : NSObject

@property (nonatomic,readonly) FMSong *currentSong;
@property (nonatomic,readonly) NSTimeInterval currentTime;
@property (nonatomic,readonly) NSTimeInterval totalTime;

@property (nonatomic,copy) NSArray *songs;
@property (nonatomic,assign) float volume;
@property (nonatomic,retain,readwrite) FMChannel *currentChannel;

#pragma mark - These methods are abstract, overide them in subclasses.
- (void)play;
- (void)stop;
- (void)pause;
- (void)resume;

- (void)like;
- (void)dislike;
- (void)skip;

- (NSInteger)unplayedSongNumber;
//- (void)setChannel:(NSString *)channelId;


#pragma mark - These are some easy constructor, do not overide.
+ (instancetype)defaultPlayer;
+ (instancetype)defaultPlayerWithSongs:(NSArray *)songs;
- (id)initWithSongs:(NSArray *)songs;
@end
