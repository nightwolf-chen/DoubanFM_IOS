//
//  FMDouStreamAdaptor.m
//  DoubanFM
//
//  Created by exitingchen on 14-8-29.
//  Copyright (c) 2014年 nirvawolf. All rights reserved.
//

#import "FMDouStreamAdaptor.h"
#import "DOUAudioStreamer.h"
#import "FMTack.h"

@interface FMPlayer ()

@property (nonatomic,retain,readwrite) FMSong *currentSong;
@property (nonatomic,retain,readwrite) FMChannel *currentChannel;
@property (nonatomic,assign,readwrite) NSTimeInterval currentTime;
@property (nonatomic,assign,readwrite) NSTimeInterval totalTime;

@end

@interface FMDouStreamAdaptor ()

@property (nonatomic,retain) DOUAudioStreamer *dPlayer;

@end

@implementation FMDouStreamAdaptor

@synthesize currentChannel;

- (void)play
{
    if (self.songQueue.count > 0) {
        
        self.currentSong = self.songQueue.firstObject;
        FMTack *aTrack = [FMTack trackWithSong:self.currentSong];
        self.dPlayer = [DOUAudioStreamer streamerWithAudioFile:aTrack];
        [self.dPlayer play];
    
    }
}

- (void)stop
{
    if (_dPlayer.status == DOUAudioStreamerPlaying) {
        [_dPlayer stop];
    }
    
    self.dPlayer = nil;
}

- (void)next
{
    if (_dPlayer) {
        [self stop];
    }
    
    [self play];
}

- (void)pause
{
    if (_dPlayer && _dPlayer.status == DOUAudioStreamerPlaying) {
        [_dPlayer pause];
    }
}

- (void)resume
{
    if (_dPlayer && _dPlayer.status == DOUAudioStreamerPaused) {
        [_dPlayer play];
    }
}

- (void)skip
{
    //TODO:additional things to perform
    
    [self next];
}

- (void)like
{
    if (self.currentSong && _dPlayer) {
        
    }
}

- (void)dislike
{
    if (self.currentSong && _dPlayer) {
        
    }
}


@end
