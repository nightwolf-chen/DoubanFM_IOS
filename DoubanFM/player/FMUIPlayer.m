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

- (void)play:(FMSong *)song;
- (void)playerItemDidReachEnd:(NSNotification *)notiication;

@end

@implementation FMUIPlayer

- (id)initWithSongs:(NSArray *)songs delegate:(id)delegate
{
    self = [super init];
    
    if (self) {
        _songQueue = [[NSMutableArray alloc] initWithArray:songs];
        _delegate = delegate;
    }
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1,1)
                                              queue:dispatch_get_main_queue()
                                         usingBlock:^(CMTime time){
                                        
                                        [self.delegate player:self
                                                  currentTime:CMTimeGetSeconds(self.player.currentTime)];
                                        
                                         }];


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
        [self.delegate playerNeedsMoreSongs:self];
    
    }
}

- (void)play:(FMSong *)song
{
    
    NSURL *url = [NSURL URLWithString:song.songUrl];
    
    AVPlayerItem *item = [[AVPlayerItem playerItemWithURL:url] retain];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:item];
    
    [self.player play];
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notiication
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.player.currentItem];
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
