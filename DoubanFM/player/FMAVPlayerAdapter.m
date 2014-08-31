//
//  FMUIPlayer.m
//  DoubanFM
//
//  Created by nirvawolf on 15/6/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMAVPlayerAdapter.h"
#import "FMSong.h"
#import <AVFoundation/AVFoundation.h>

const NSString *FMUIPLayerNeedsNewSongsNotification = @"__FMUIPLayerNeedsNewSongsNotification__";

@interface FMPlayer ()
@property (nonatomic,retain,readwrite) FMSong *currentSong;
@property (nonatomic,assign,readwrite) NSTimeInterval currentTime;
@property (nonatomic,assign,readwrite) NSTimeInterval totalTime;
@end

@interface FMAVPlayerAdapter ()
@property (nonatomic,readonly,retain) AVQueuePlayer *player;
@property (nonatomic,retain) NSArray *fmPlayItems;

- (void)play:(FMSong *)song;
- (void)playerItemDidReachEnd:(NSNotification *)notiication;
@end

@implementation FMAVPlayerAdapter

- (id)initWithSongs:(NSArray *)songs
{
    self = [super init];
    
    if (self) {
        self.songs = [[NSMutableArray alloc] initWithArray:songs];
        _player = [[AVQueuePlayer alloc] init];
    }
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1,1)
                                              queue:dispatch_get_main_queue()
                                         usingBlock:^(CMTime time){
                                        
                                        [self.delegate player:self
                                                  currentTime:CMTimeGetSeconds(self.player.currentTime)
                                                    totalTime:CMTimeGetSeconds([self.player.currentItem duration])];
                                        
                                         }];

    return self;
}

- (void)start
{
    FMSong *aSong = [self.songs lastObject];
    
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
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    [self.player replaceCurrentItemWithPlayerItem:item];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:item];
    
    [self.player play];
    [self.delegate playerIsLoadingSong:self];
    
}

- (void)playerItemDidReachEnd:(NSNotification *)notiication
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:self.player.currentItem];
//    [self.songQueue removeLastObject];
    [self start];
}

- (void)next
{
    [self playerItemDidReachEnd:nil];
}

- (FMSong*) getPlayingSong
{
    return [self.songs lastObject];
}


@end
