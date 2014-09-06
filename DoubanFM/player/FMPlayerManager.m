//
//  FMPlayerManager.m
//  DoubanFM
//
//  Created by nirvawolf on 30/8/14.
//  Copyright (c) 2014 nirvawolf. All rights reserved.
//

#import "FMPlayerManager.h"
#import "FMPlayer.h"
#import "FMDouStreamAdaptor.h"
#import "FMChannel.h"
#import "FMApiRequestSongInfo.h"
#import "FMApiRequestSong.h"
#import "FMApiResponseSong.h"
#import "FMApiResponse.h"
#import "DOUStreamPlayer/DOUAudioStreamer.h"
@interface FMPlayerManager ()

@property (nonatomic,retain) FMApiRequest *request;

@end

@implementation FMPlayerManager

+ (instancetype)sharedInstance
{
    static id _instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[FMPlayerManager alloc] _init];
    });
    
    return _instance;
}

+ (FMChannel *)defaultChannel
{
    FMChannel *channel = [[FMChannel alloc] init];
    channel.channelId = 0;
    channel.nameCN = @"华语";
    
    return [channel autorelease];
}

- (id)init
{
    NSAssert(NO,@"Must use sharedManager");
    return nil;
}

- (void)dealloc
{
    SAFE_DELETE(_activePlayer);
    SAFE_DELETE(_request);
    
    [super dealloc];
}

- (id)_init
{
    if (self = [super init]) {
        _activePlayer = [[FMPlayer defaultPlayer] retain];
        
        _currentChannel = [self.class defaultChannel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerStatusDidChange:)
                                                     name:FMDounStreamAdaptorStatusChangedNotification
                                                   object:nil];
        
        [self loadSongsFromServer];
    }
    return self;
}

- (void)loadSongsFromServer
{
    FMChannel *channel = [self.class defaultChannel];
    NSString *channelId = [NSString stringWithFormat:@"%d",channel.channelId];
    FMApiRequestSongInfo *info = [[FMApiRequestSongInfo alloc] initWith:SongRequestTypeNEW song:nil channel:channelId];

    self.request = [[FMApiRequestSong alloc] init:info
                                       completion:^(FMApiResponse *response){
                                           
                                                FMApiResponseSong *songResp = (FMApiResponseSong *)response;
                                                _activePlayer.songs = songResp.songs;
                                                _activePlayer.currentChannel = channel;
                                                [_activePlayer play];
                                           
                                       }
                                         errBlock:^(NSError *error){
                                                      
                                                NSLog(@"Error loading songs via network!");
                                    }];
    
    [_request sendRequest];
    
    [info release];
}

- (void)playerStatusDidChange:(NSNotification *)notificatioin
{
    NSDictionary *userInfo = notificatioin.userInfo;
    
    if ([userInfo[@"status"] integerValue] == DOUAudioStreamerFinished){
        
        if ([_activePlayer unplayedSongNumber] > 0) {
            [_activePlayer play];
        }else{
            [self loadSongsFromServer];
        }
        
    }
}
@end
