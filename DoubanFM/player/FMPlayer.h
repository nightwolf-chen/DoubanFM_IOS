//
//  FMPlayer.h
//  DoubanFM
//
//  Created by exitingchen on 14-8-29.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSInteger, FMPlayerStatus){
//    FMPlayerPlaying,
//    FMPlayerStoped,
//    FMPlayerPaused,
//    FMPlayerUnprepared,
//    FMPlayerReadyToPlay,
//    FMPlayerAllFinished
//};

@class FMSong,FMChannel;
@protocol FMPlayerDelegate;

@interface FMPlayer : NSObject
{
    struct {
        unsigned int didLikeSong : 1;
        unsigned int didMoveSongToTrash : 1;
        unsigned int didDislikeSong : 1;
        unsigned int didSkipSong : 1;
        unsigned int didEndSong : 1;
    }_delegateFlags;
}

@property (nonatomic,readonly) FMSong *currentSong;
@property (nonatomic,readonly) NSTimeInterval currentTime;
@property (nonatomic,readonly) NSTimeInterval totalTime;

@property (nonatomic,copy) NSArray *songs;
@property (nonatomic,assign) float volume;
@property (nonatomic,retain) FMChannel *currentChannel;

@property (nonatomic,assign) id<FMPlayerDelegate> delegate;

#pragma mark - These methods are abstract, overide them in subclasses.
- (void)play;
- (void)stop;
- (void)pause;
- (void)resume;

- (void)like;
- (void)dislike;
- (void)skip;
- (void)trash;

- (NSInteger)unplayedSongNumber;

#pragma mark - These are some easy constructor, do not overide.
+ (instancetype)defaultPlayer;
+ (instancetype)defaultPlayerWithSongs:(NSArray *)songs;
- (id)initWithSongs:(NSArray *)songs;
@end

@protocol FMPlayerDelegate <NSObject>

@required
- (void)player:(FMPlayer *)player didLikeSong:(FMSong *)song;
- (void)player:(FMPlayer *)player didDislikeSong:(FMSong *)song;
- (void)player:(FMPlayer *)player didMoveSongToTrash:(FMSong *)song;
- (void)player:(FMPlayer *)player didSkipSong:(FMSong *)song;
- (void)player:(FMPlayer *)player didEndSong:(FMSong *)song;

@end
