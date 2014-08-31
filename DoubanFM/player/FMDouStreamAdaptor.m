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
@property (nonatomic,assign,readwrite) NSTimeInterval currentTime;

@end

@interface FMDouStreamAdaptor ()

@property (nonatomic,retain) DOUAudioStreamer *dPlayer;
@property (nonatomic,retain,readwrite) NSMutableArray *tracks;

@end

static void *kKVOContext = &kKVOContext;

@implementation FMDouStreamAdaptor

- (void)dealloc
{
    self.currentChannel = nil;
    self.currentSong = nil;
    self.songs = nil;
    self.dPlayer = nil;
    self.tracks = nil;
    
    [super dealloc];
}

#pragma mark - player control.
- (void)play
{
    if (self.tracks.count > 0) {
        
        if (_dPlayer) {
            [_dPlayer removeObserver:self forKeyPath:@"status" context:kKVOContext];
        }
        
        FMTack *aTrack = [_tracks lastObject];
        self.dPlayer = [DOUAudioStreamer streamerWithAudioFile:aTrack];
        [_dPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kKVOContext];
        [_dPlayer play];
        
        self.currentSong = aTrack.song;
    }
}

- (void)stop
{
    [_dPlayer stop];
}

- (void)next
{
    [self stop];
    
    [self popTrack];
    
    [self play];
}

- (void)pause
{
    
}

- (void)resume
{
    if (_dPlayer && _dPlayer.status == DOUAudioStreamerPaused) {
        [_dPlayer play];
    }
}

- (float)volume
{
    if (_dPlayer) {
        return _dPlayer.volume;
    }
    
    return -1.0f;
}

- (void)setVolume:(float)volume
{
    if (_dPlayer) {
        [_dPlayer setVolume:volume];
    }
}

#pragma mark - User acts.
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

- (BOOL)popTrack
{
    if (_tracks) {
        [_tracks removeLastObject];
        return YES;
    }
    
    return NO;
}

- (void)setSongs:(NSArray *)songs
{
    [super setSongs:songs];
    [self addSongsToTrackQueue];
}

- (void)addSongsToTrackQueue
{
    self.tracks = [NSMutableArray arrayWithCapacity:self.songs.count];
    for(FMSong *song in self.songs){
        [_tracks addObject:[FMTack trackWithSong:song]];
    }
 
}

- (NSTimeInterval)totalTime
{
    return _dPlayer.duration;
}

- (NSTimeInterval)currentTime
{
    return _dPlayer.currentTime;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    [_dPlayer setCurrentTime:currentTime];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        DOUAudioStreamerStatus status = [change[@"new"] integerValue];
        
        if (status == DOUAudioStreamerFinished) {
            [self play];
        }
    }
    
}
@end
