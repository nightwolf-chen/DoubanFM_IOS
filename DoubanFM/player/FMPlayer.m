//
//  FMPlayer.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-29.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMPlayer.h"
#import "FMDouStreamAdaptor.h"
#import "FMAVPlayerAdapter.h"


@interface FMPlayer ()
{
    
}

@property (nonatomic,retain,readwrite) FMSong *currentSong;
@property (nonatomic,assign,readwrite) NSTimeInterval currentTime;
@property (nonatomic,assign,readwrite) NSTimeInterval totalTime;

@end

@implementation FMPlayer

+ (instancetype)defaultPlayer
{
    return [[[FMDouStreamAdaptor alloc] init] autorelease];
}

+ (instancetype)defaultPlayerWithSongs:(NSArray *)songs
{
    return [[[FMDouStreamAdaptor alloc] initWithSongs:songs] autorelease];
}

- (id)initWithSongs:(NSArray *)songs
{
    if (self = [super init]) {
        _songs = [songs retain];
    }
    
    return self;
}

- (void)setDelegate:(id<FMPlayerDelegate>)delegate
{
    _delegate = delegate;
    _delegateFlags.didLikeSong = [delegate respondsToSelector:@selector(player:didLikeSong:)];
    _delegateFlags.didDislikeSong = [delegate respondsToSelector:@selector(player:didDislikeSong:)];
    _delegateFlags.didEndSong = [delegate respondsToSelector:@selector(player:didEndSong:)];
    _delegateFlags.didSkipSong = [delegate respondsToSelector:@selector(player:didSkipSong:)];
    _delegateFlags.didMoveSongToTrash = [delegate respondsToSelector:@selector(player:didMoveSongToTrash:)];
}

#pragma mark abstract methods
- (NSInteger)unplayedSongNumber
{
    [self abstractMethodWarnning];
    return 0;
}

- (void)play
{
    [self abstractMethodWarnning];
}

- (void)stop
{
    [self abstractMethodWarnning];
}

- (void)pause
{
    [self abstractMethodWarnning];
}

- (void)resume
{
    [self abstractMethodWarnning];
}

- (void)next
{
    [self abstractMethodWarnning];
}

- (void)skip
{
    [self abstractMethodWarnning];
}

- (void)like
{
    [self abstractMethodWarnning];
}

- (void)dislike
{
    [self abstractMethodWarnning];
}

- (void)trash
{
    [self abstractMethodWarnning];
}

- (void)setChannel:(NSString *)channelId
{
    [self abstractMethodWarnning];
}

- (void)abstractMethodWarnning
{
    @throw [NSException exceptionWithName:@"Abstract method exception"
                                   reason:@"Call an unimplemented abstract method!"
                                 userInfo:nil];
}




@end
