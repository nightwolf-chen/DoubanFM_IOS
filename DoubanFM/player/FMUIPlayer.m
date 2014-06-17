//
//  FMUIPlayer.m
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMUIPlayer.h"
#import "FMSong.h"
#import <AVFoundation/AVFoundation.h>

const NSString *FMUIPLayerNeedsNewSongsNotification = @"__FMUIPLayerNeedsNewSongsNotification__";

@interface FMUIPlayer ()
{
    AVPlayerItem *_playingItem;
}

- (void)play:(FMSong *)song;
- (void)playerItemDidReachEnd:(NSNotification *)notiication;

@end

@implementation FMUIPlayer

- (id)initWithSongs:(NSArray *)songs
{
    self = [super init];
    
    if (self) {
        _songQueue = [[NSMutableArray alloc] initWithArray:songs];
    }
    
    return self;
}

- (void)start
{
    FMSong *aSong = [self.songQueue lastObject];
    
    if (aSong) {
        [self play:aSong];
    }else{
        //No songs available!
        NSLog(@"No songs!");
        [[NSNotificationCenter defaultCenter] postNotificationName:(NSString *)FMUIPLayerNeedsNewSongsNotification object:nil];
    }
}

- (void)play:(FMSong *)song
{
    
    NSURL *url = [NSURL URLWithString:song.songUrl];
    
    _playingItem = [[AVPlayerItem playerItemWithURL:url] retain];
    
    [self.player replaceCurrentItemWithPlayerItem:_playingItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:_playingItem];
    
    [self.player play];
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notiication
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:_playingItem];
    [self.songQueue removeLastObject];
    [self start];
}

- (void)next
{
    [self playerItemDidReachEnd:nil];
}

- (FMSong*) getPlayingSong
{
    return [self.songQueue lastObject];
}

@end
