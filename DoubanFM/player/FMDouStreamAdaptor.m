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

NSString *const FMDounStreamAdaptorStatusChangedNotification = @"_FMDounStreamAdaptorStatusChangedNotification_";

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
    @synchronized(self){
    
        if (_tracks.count > 0) {
            
            FMTack *aTrack = [_tracks lastObject];
            self.dPlayer = [DOUAudioStreamer streamerWithAudioFile:aTrack];
            [_dPlayer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kKVOContext];
            [_dPlayer play];
            
            self.currentSong = aTrack.song;
            
        }else{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:FMDounStreamAdaptorStatusChangedNotification
                                                                object:self
                                                              userInfo:@{@"status": @(DOUAudioStreamerFinished)}];
        }
        
    }
}

- (void)setDPlayer:(DOUAudioStreamer *)dPlayer
{
    if (_dPlayer) {
        [_dPlayer removeObserver:self forKeyPath:@"status" context:kKVOContext];
        SAFE_DELETE(_dPlayer);
    }
    
    _dPlayer = [dPlayer retain];
}

- (void)stop
{
    [_dPlayer stop];
    [self p_cleaupPlayer];
}

- (void)p_cleaupPlayer
{
    [self popTrack];
    self.currentSong = nil;
    self.dPlayer = nil;
}

- (void)next
{
    [self stop];
    [self play];
}

- (void)pause
{
    [_dPlayer pause];
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
    if (self->_delegateFlags.didSkipSong) {
        [self.delegate player:self didEndSong:self.currentSong];
    }
    
    [self next];
}

- (void)like
{
    if (self.currentSong && _dPlayer) {
        if (self->_delegateFlags.didLikeSong) {
            [self.delegate player:self didLikeSong:self.currentSong];
        }
    }
}

- (void)dislike
{
    if (self.currentSong && _dPlayer) {
        if (self->_delegateFlags.didDislikeSong) {
            [self.delegate player:self didDislikeSong:self.currentSong];
        }
    }
}

- (void)trash
{
    if (self.currentSong && _dPlayer) {
        if (self->_delegateFlags.didMoveSongToTrash) {
            [self.delegate player:self didMoveSongToTrash:self.currentSong];
        }
    }
    [self next];
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
//    NSLog(@"currentTime:%f",_dPlayer.currentTime);
    return _dPlayer.currentTime;
}

- (void)setCurrentTime:(NSTimeInterval)currentTime
{
    [_dPlayer setCurrentTime:currentTime];
}

- (NSInteger)unplayedSongNumber
{
    if (!_tracks) {
        return 0;
    }
    return _tracks.count;
}
#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"]) {
        
        DOUAudioStreamerStatus status = [change[@"new"] integerValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:FMDounStreamAdaptorStatusChangedNotification
                                                            object:self
                                                          userInfo:@{@"status": @(status)}];
        
        if (status == DOUAudioStreamerFinished) {
            if (self->_delegateFlags.didEndSong) {
                [self.delegate player:self didEndSong:self.currentSong];
            }
        }
        
    }
    
}

@end
