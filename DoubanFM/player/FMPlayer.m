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

- (void)setChannel:(NSString *)channelId
{
    [self abstractMethodWarnning];
}

- (void)abstractMethodWarnning
{
    @throw @"This is a abstract method!";
}




@end
